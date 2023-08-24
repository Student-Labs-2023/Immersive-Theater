import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/theme.dart';

class AppButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final double heightCoef;
  final double widthCoef;

  const AppButton({
    Key? key,
    required this.title,
    required this.onTap,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    this.heightCoef = 0.06,
    this.widthCoef = 0.91,
  }) : super(key: key);
  const AppButton.primaryButton({
    super.key,
    required this.title,
    required this.onTap,
    this.heightCoef = 0.06,
    this.widthCoef = 0.91,
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
            MediaQuery.of(context).size.width * widthCoef,
            MediaQuery.of(context).size.height * heightCoef,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: textColor,
                  fontFamily: primaryFont,
                ),
          ),
        ],
      ),
    );
  }
}
