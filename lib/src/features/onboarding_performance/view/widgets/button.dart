import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';

class Button extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final String icon;

  const Button({
    super.key,
    required this.title,
    required this.onTap,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.icon,
  });
  const Button.purpleButton({
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
