import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/ui/app_button.dart';
import 'package:shebalin/src/theme/ui/app_text_header.dart';

class DialogWindow extends StatelessWidget {
  final String title;
  final String subtitle;
  final String titlePrimary;
  final String titleSecondary;
  final void Function() onTapPrimary;
  final void Function() onTapSecondary;
  const DialogWindow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTapPrimary,
    required this.titlePrimary,
    required this.titleSecondary,
    required this.onTapSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextHeader(title: title),
          const SizedBox(
            height: 8,
          ),
          subtitle.isNotEmpty
              ? Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColor.greyText),
                )
              : const SizedBox(),
          const SizedBox(
            height: 10,
          ),
          AppButton(
            backgroundColor: AppColor.destructiveAlertDialog,
            borderColor: AppColor.destructiveAlertDialog,
            onTap: onTapPrimary,
            textColor: AppColor.whiteText,
            title: titlePrimary,
            heightCoef: 0.045,
          ),
          const SizedBox(
            height: 3,
          ),
          AppButton(
            backgroundColor: AppColor.whiteBackground,
            borderColor: AppColor.lightGray,
            onTap: onTapSecondary,
            textColor: AppColor.blackText,
            title: titleSecondary,
            heightCoef: 0.045,
          ),
        ],
      ),
    );
  }
}

class AlertDialogButton extends StatelessWidget {
  const AlertDialogButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.isPrimary,
  });

  final VoidCallback onTap;
  final String title;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0),
        overlayColor: MaterialStatePropertyAll(Theme.of(context).focusColor),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        backgroundColor:
            const MaterialStatePropertyAll(AppColor.whiteBackground),
      ),
      onPressed: onTap,
      child: Text(
        title,
        style: isPrimary
            ? Theme.of(context).textTheme.bodyLarge
            : Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.purplePrimary,
                ),
      ),
    );
  }
}
