import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/theme.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onButtonClickFunction,
    required this.buttonTitle,
    required this.width,
    required this.height,
  });
  final Function() onButtonClickFunction;
  final String buttonTitle;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(accentTextColor),
        elevation: MaterialStateProperty.all(5),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        minimumSize: MaterialStateProperty.all(Size(width, height)),
      ),
      onPressed: onButtonClickFunction,
      child: Text(
        buttonTitle,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
