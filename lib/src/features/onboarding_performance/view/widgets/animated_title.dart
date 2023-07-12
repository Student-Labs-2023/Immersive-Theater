import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onboarding_performance/models/onboard_performance.dart';

class AnimatedTitle extends StatelessWidget {
  const AnimatedTitle({
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
      child: Text(
        key: Key(currentIndex.toString()),
        textAlign: TextAlign.center,
        pages[currentIndex].title,
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}
