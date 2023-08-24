import 'package:flutter/material.dart';

import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/ui/app_button.dart';

class OnboardControllButton extends StatelessWidget {
  final String titlePrimary;
  final void Function() onTapPrimary;
  final String titleSecondary;
  final void Function() onTapSecondary;
  const OnboardControllButton({
    super.key,
    required this.titlePrimary,
    required this.onTapPrimary,
    required this.titleSecondary,
    required this.onTapSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppButton.primaryButton(
          title: titlePrimary,
          onTap: onTapPrimary,
        ),
        const SizedBox(
          height: 16,
        ),
        AppButton(
          title: titleSecondary,
          onTap: onTapSecondary,
          textColor: AppColor.blackText,
          backgroundColor: AppColor.whiteBackground,
          borderColor: AppColor.yellowSecondary,
        ),
      ],
    );
  }
}
