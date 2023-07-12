import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onboarding_performance/models/onboard_performance.dart';
import 'package:shebalin/src/theme/app_color.dart';

class AnimatedBottomSheet extends StatelessWidget {
  const AnimatedBottomSheet({
    super.key,
    required this.pages,
    required this.currentIndex,
    required this.child,
  });

  final List<OnboardPerformance> pages;
  final int currentIndex;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 44,
            spreadRadius: 0,
            offset: const Offset(0, -12),
            color: AppColor.blackText.withOpacity(0.12),
          )
          // blurStyle: BlurStyle.solid)
        ],
        color: AppColor.whiteBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: child,
    );
  }
}
