import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';

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
          constraints: BoxConstraints(
            minHeight: 50,
            minWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(79.0),
            color: AppColor.purplePrimary,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColor.whiteText),
              ),
              const SizedBox(
                width: 13,
              ),
              const ImageIcon(
                AssetImage(ImagesSources.right),
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
