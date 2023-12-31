import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';

class AnimatedSubtitle extends StatelessWidget {
  const AnimatedSubtitle({
    super.key,
    required this.subtitle,
    required this.subtitleAccent,
  });

  final String subtitle;
  final String subtitleAccent;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: AppSubtitle(
        subtitle: subtitle,
        subtitleAccent: subtitleAccent,
        key: Key(subtitle),
      ),
    );
  }
}

class AppSubtitle extends StatelessWidget {
  const AppSubtitle({
    super.key,
    required this.subtitle,
    required this.subtitleAccent,
  });

  final String subtitle;
  final String subtitleAccent;

  @override
  Widget build(BuildContext context) {
    return RichText(
      key: key,
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: subtitle,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColor.greyText,
                ),
          ),
          TextSpan(
            text: subtitleAccent,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: AppColor.purpleLightPrimary),
          )
        ],
      ),
    );
  }
}
