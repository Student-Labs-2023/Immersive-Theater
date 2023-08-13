import 'package:flutter/material.dart';
import 'package:shebalin/src/features/authorization/widgets/phone_number_field.dart';
import 'package:shebalin/src/features/authorization/widgets/sms_code_input_page.dart';
import 'package:shebalin/src/theme/app_color.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  static const String routeName = "/auth-screen";
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.whiteBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Номер телефона",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 20),
              child: Text(
                "Он нужен, чтобы сохранять ваши спектакли",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColor.greyText),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 31), child:  PhoneNumberField(),),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pushNamed(SMSCodeInputPage.routeName,arguments: "+79509999999");
              },
              style: ButtonStyle(
                elevation: const MaterialStatePropertyAll(0),
                backgroundColor: MaterialStateProperty.all(AppColor.purplePrimary),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height * 0.06,
                  ),
                ),
              ),
              child: Text(
                'Далее',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColor.whiteText),

              ),
            )
          ],
        ),
      ),
    );
  }
}
