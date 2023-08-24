import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:authentication_repository/src/exceptions/exceptions.dart';
import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _cache = cache ?? CacheClientImpl(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;
  static const userCacheKey = '__user_cache_key';
  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  String _verificationId = '';

  @override
  Stream<UserModel> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? UserModel.empty : firebaseUser.toUser;
      _cache.write<UserModel>(key: userCacheKey, value: user);
      return user;
    });
  }

  UserModel get currentUser {
    return _cache.read<UserModel>(key: userCacheKey) ?? UserModel.empty;
  }

  @override
  Future<void> verifyPhoneNumber({required String phoneNumber}) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        codeAutoRetrievalTimeout: (String verificationId) {},
        codeSent: (String verificationId, int? forceResendingToken) {
          _verificationId = verificationId;
        },
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (FirebaseAuthException error) {},
      );
    } catch (_) {
      throw PhoneNumberFailure();
    }
  }

  @override
  Future<void> verifyOTP({required String smsCode}) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          smsCode: smsCode, verificationId: _verificationId);
      await _firebaseAuth.signInWithCredential(phoneAuthCredential);
    } catch (_) {
      throw PhoneNumberFailure();
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  UserModel get toUser {
    return UserModel(id: uid, phoneNumber: phoneNumber);
  }
}
