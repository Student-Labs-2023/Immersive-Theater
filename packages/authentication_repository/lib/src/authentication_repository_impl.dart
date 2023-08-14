import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:authentication_repository/src/exceptions/exceptions.dart';
import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:authentication_repository/src/authentication_repository.dart';

import 'models/models.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _cache = cache ?? CacheClientImpl(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;
  static const userCacheKey = '__user_cache_key__';
  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.write<User>(key: userCacheKey, value: user);
      return user;
    });
  }

  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  @override
  Future<void> logIn({required String phoneNumber}) async {
    try {
      await _firebaseAuth.signInWithPhoneNumber(phoneNumber);
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
  User get toUser {
    return User(id: uid, phoneNumber: phoneNumber);
  }
}
