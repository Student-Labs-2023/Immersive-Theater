import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';

class ContinueButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  const ContinueButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: accentTextColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColor.whiteText,
                    ),
              ),
              const SizedBox(
                width: 3,
              ),
              const ImageIcon(
                AssetImage(ImagesSources.continueButton),
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
