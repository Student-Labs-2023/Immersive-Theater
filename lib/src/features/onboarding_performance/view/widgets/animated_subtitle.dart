import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onboarding_performance/models/onboard_performance.dart';
import 'package:shebalin/src/theme/app_color.dart';

class AnimatedSubtitle extends StatelessWidget {
  const AnimatedSubtitle({
    super.key,
    required this.currentIndex,
    required this.pages,
  });

  final int currentIndex;
  final List<OnboardPerformance> pages;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: RichText(
        key: Key(currentIndex.toString()),
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: pages[currentIndex].subtitle,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColor.greyText,
                  ),
            ),
            TextSpan(
              text: pages[currentIndex].subtitleAccent,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColor.purpleLightPrimary),
            )
          ],
        ),
      ),
    );
  }
}
