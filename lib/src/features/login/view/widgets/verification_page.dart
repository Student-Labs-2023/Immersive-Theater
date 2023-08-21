import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:shebalin/src/features/authentication/bloc/authentication_bloc.dart';
import 'package:shebalin/src/features/detailed_performaces/view/widgets/text_with_leading.dart';
import 'package:shebalin/src/features/login/bloc/login_bloc.dart';
import 'package:shebalin/src/features/main_screen/view/main_screen.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/ui/app_text_header.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({
    super.key,
  });

  static const routeName = 'verify';

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _controller = TextEditingController();
  bool isWrongCode = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, current) {
        return previous.status == AuthenticationStatus.unauthenticated &&
            current.status == AuthenticationStatus.authenticated;
      },
      listener: (context, state) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          MainScreen.routeName,
          ModalRoute.withName(MainScreen.routeName),
        );
      },
      child: Scaffold(
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
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (!state.isValidCode) {
              setState(() {
                _controller.clear();
                isWrongCode = true;
              });
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppTextHeader(title: 'Код из SMS'),
                  const SizedBox(
                    height: 4,
                  ),
                  AppTextSubtitle(
                    title:
                        'Он отправлен на  номер ${context.watch<LoginBloc>().state.phoneNumber.value}',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Pinput(
                    controller: _controller,
                    enabled: true,
                    length: 6,
                    defaultPinTheme: PinTheme(
                      height: MediaQuery.of(context).size.width / 10,
                      width: 40,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 4.0,
                              color:
                                  (_controller.text.isEmpty && isWrongCode)
                                      ? AppColor.redAlert
                                      : AppColor.grey,
                          ),
                        ),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      height: MediaQuery.of(context).size.width / 10,
                      width: 40,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 4.0,
                            color: AppColor.yellowSecondary,
                          ),
                        ),
                      ),
                    ),
                    onCompleted: (code) {
                      context
                          .read<LoginBloc>()
                          .add(LoginVerifyOTP(smsCode: code));
                    },
                  ),
                  isWrongCode
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                            "Неверный код",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppColor.redAlert,
                                    ),
                          ),
                        )
                      : const SizedBox(
                          height: 20,
                        ),
                  InkWell(
                    child: Text(
                      "Отправить код повторно",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColor.purplePrimary,
                          ),
                    ),
                    onTap: () => context.read<LoginBloc>().add(
                          const LoginVerifyPhoneNumber(),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
