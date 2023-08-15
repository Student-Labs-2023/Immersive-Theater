import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:shebalin/src/features/detailed_performaces/view/widgets/text_with_leading.dart';
import 'package:shebalin/src/features/login/bloc/login_bloc.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/ui/app_text_header.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key, required this.phoneNumber});
  final String phoneNumber;
  static const routeName = '/verify';
  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteBackground,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.whiteBackground,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColor.greyText,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppTextHeader(title: 'Код из SMS'),
              AppTextSubtitle(
                title: 'Он отправлен на  номер ${widget.phoneNumber}',
              ),
              Pinput(
                length: 6,
                defaultPinTheme: PinTheme(
                  height: MediaQuery.of(context).size.width / 10,
                  width: 40,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.black),
                    ),
                  ),
                ),
                focusedPinTheme: PinTheme(
                  height: MediaQuery.of(context).size.width / 10,
                  width: 40,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: AppColor.yellowSecondary,
                      ),
                    ),
                  ),
                ),
                onCompleted: (code) {
                  context.read<LoginBloc>().add(LoginVerifyOTP(smsCode: code));
                },
              ),
              InkWell(
                child: Text(
                  "Отправить код повторно",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColor.purplePrimary,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
