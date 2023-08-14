import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onbording/view/onbording_screen.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:sms_autofill/sms_autofill.dart';

class SMSCodeInputPage extends StatefulWidget {
  const SMSCodeInputPage({super.key, required this.phoneNumber});
  final String phoneNumber;
  static const String routeName = "/sms-page";
  @override
  State<SMSCodeInputPage> createState() => _SMSCodeInputPageState();
}

class _SMSCodeInputPageState extends State<SMSCodeInputPage> {
  static final controller = TextEditingController();
  bool isValid = true;

  @override
  void initState() {
    controller.addListener(() {
      if (controller.text.isNotEmpty) {
        isValid = controller.text == "0000";
        //TODO: add sms validation
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.selection = const TextSelection.collapsed(offset: 0);
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
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Код из SMS",
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 20),
              child: Text(
                "Он отправлен на номер ${widget.phoneNumber}",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColor.greyText),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.49,
              height: MediaQuery.of(context).size.height * 0.059,
              child: PinFieldAutoFill(
                focusNode: FocusNode(),
                autoFocus: true,
                onCodeSubmitted: (code) {
                  //TODO: code checking
                  if (isValid) {
                    Navigator.of(context).pushNamed(OnbordingScreen.routeName);
                  }
                },
                controller: controller,
                codeLength: 4,
                decoration: UnderlineDecoration(
                  gapSpaces: [8.0, 8.0, 8.0],
                  lineStrokeCap: StrokeCap.round,
                  textStyle: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 24),
                  lineHeight: 4,
                  gapSpace: 4,
                  colorBuilder: isValid
                      ? const FixedColorBuilder(AppColor.grey)
                      : const FixedColorBuilder(AppColor.redAlert),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: InkWell(
                child: Text(
                  "Отправить код повторно",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColor.purplePrimary,
                      ),
                ),
                onTap: () {
                  //TODO: implement code re-send
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
