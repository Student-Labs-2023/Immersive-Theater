import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onboarding_performance/models/onboard_performance.dart';
import 'package:shebalin/src/theme/app_color.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.pages,
    required this.currentIndex,
  });

  final List<OnboardPerformance> pages;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ...List.generate(
          pages.length,
          (index) => DotIndicator(
            isActive: index == currentIndex,
          ),
        ),
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  final bool isActive;
  const DotIndicator({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 8,
        width: 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: isActive ? AppColor.yellowSecondary : AppColor.grey,
        ),
      ),
    );
  }
}
