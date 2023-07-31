import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onboarding_performance/models/onboard_performance.dart';
import 'package:shebalin/src/theme/app_color.dart';

class PageIndicator extends StatelessWidget {
  PageIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    required this.elementHeight,
    required this.elementWidth,
  });

  final int count;
  final int currentIndex;
  double elementWidth = 8;
  double elementHeight = 8;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ...List.generate(
          count,
          (index) => DotIndicator(
            isActive: index == currentIndex,
            height: elementHeight,
            width: elementWidth,
          ),
        ),
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  final bool isActive;
  double width;
  double height;
  DotIndicator(
      {super.key,
      required this.isActive,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: isActive ? AppColor.yellowSecondary : AppColor.grey,
        ),
      ),
    );
  }
}
