import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shebalin/src/features/login/bloc/login_bloc.dart';
import 'package:shebalin/src/features/login/view/widgets/verification_page.dart';
import 'package:shebalin/src/features/detailed_performaces/view/widgets/text_with_leading.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/ui/app_button.dart';
import 'package:shebalin/src/theme/ui/app_text_header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName = 'login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 48, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppTextHeader(title: 'Номер телефона'),
              const SizedBox(
                height: 4,
              ),
              const AppTextSubtitle(
                title: 'Он нужен, чтобы сохранять ваши спектакли',
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: _key,
                        child: TextFormField(
                          initialValue: "+7 ",
                          keyboardType: TextInputType.phone,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    leadingDistribution:
                                        TextLeadingDistribution.even,
                                  ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            MaskTextInputFormatter(
                              mask: '+# ### ###-##-##',
                              type: MaskAutoCompletionType.lazy,
                            )
                          ],
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          onChanged: (phoneNumber) {
                            context.read<LoginBloc>().add(
                                  LoginPhoneNumberChanged(
                                    phoneNumber: phoneNumber,
                                  ),
                                );
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: state.isValidPassword
                                ? AppColor.whiteBackground
                                : AppColor.alertTextFieldBg,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 14.5,
                              horizontal: 16,
                            ),
                            border:
                                Theme.of(context).inputDecorationTheme.border,
                            focusedBorder: state.isValidPassword
                                ? Theme.of(context)
                                    .inputDecorationTheme
                                    .focusedBorder
                                : Theme.of(context)
                                    .inputDecorationTheme
                                    .errorBorder,
                            errorBorder: Theme.of(context)
                                .inputDecorationTheme
                                .errorBorder,
                          ),
                        ),
                      ),
                      state.isValidPassword
                          ? const SizedBox(
                              height: 31,
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.only(top: 4, bottom: 15),
                              child: Text(
                                "Номер введён не полностью",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: AppColor.destructiveAlertDialog,
                                    ),
                              ),
                            ),
                    ],
                  );
                },
              ),
              AppButton.primaryButton(title: 'Далее', onTap: _onPressed)
            ],
          ),
        ),
      ),
    );
  }

  void _onPressed() {
    if (!_key.currentState!.validate()) return;
    context.read<LoginBloc>().add(const LoginVerifyPhoneNumber());
    Navigator.of(context).pushNamed(
      VerificationPage.routeName,
    );
  }
}
