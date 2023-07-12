import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onboarding_performance/models/onboard_performance.dart';

class AnimatedImage extends StatelessWidget {
  const AnimatedImage({
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
      child: SafeArea(
        key: Key(currentIndex.toString()),
        child: Image.asset(
          width: double.infinity,
          pages[currentIndex].image,
        ),
      ),
    );
  }
}
