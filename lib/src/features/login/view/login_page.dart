import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shebalin/src/features/login/bloc/login_bloc.dart';
import 'package:shebalin/src/features/login/view/widgets/verification_page.dart';
import 'package:shebalin/src/features/detailed_performaces/view/widgets/text_with_leading.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/app_icon_button.dart';
import 'package:shebalin/src/theme/ui/app_text_header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const routeName = '/login';

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
                  return Form(
                    key: _key,
                    child: TextFormField(
                      initialValue: "+7",
                      keyboardType: TextInputType.phone,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            leadingDistribution: TextLeadingDistribution.even,
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
                              LoginPhoneNumberChanged(phoneNumber: phoneNumber),
                            );
                      },
                      validator: (_) =>
                          state.isValid ? null : 'Номер введён не полностью',
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14.5, horizontal: 16),
                        border: Theme.of(context).inputDecorationTheme.border,
                        focusedBorder: Theme.of(context)
                            .inputDecorationTheme
                            .focusedBorder,
                        errorBorder:
                            Theme.of(context).inputDecorationTheme.errorBorder,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 31,
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

extension on PhoneNumberValidationError {
  String? text() {
    switch (this) {
      case PhoneNumberValidationError.invalid:
        return 'Номер введён не полностью';
    }
  }
}
