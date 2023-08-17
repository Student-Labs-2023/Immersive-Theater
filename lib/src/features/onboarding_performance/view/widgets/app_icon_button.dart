import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';

class AppIconButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final String icon;

  const AppIconButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.icon,
  });
  const AppIconButton.primaryButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
  })  : textColor = AppColor.whiteText,
        backgroundColor = AppColor.purplePrimary,
        borderColor = AppColor.purplePrimary;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        minimumSize: MaterialStateProperty.all(
          Size(
            MediaQuery.of(context).size.width * 0.85,
            MediaQuery.of(context).size.height * 0.06,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: textColor),
          ),
          const SizedBox(
            width: 9,
          ),
          ImageIcon(
            AssetImage(icon),
            color: textColor,
            size: 24,
          )
        ],
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;

  const AppButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
  });
  const AppButton.primaryButton({
    super.key,
    required this.title,
    required this.onTap,
  })  : textColor = AppColor.whiteText,
        backgroundColor = AppColor.purplePrimary,
        borderColor = AppColor.purplePrimary;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        minimumSize: MaterialStateProperty.all(
          Size(
            MediaQuery.of(context).size.width * 0.85,
            MediaQuery.of(context).size.height * 0.06,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}

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
