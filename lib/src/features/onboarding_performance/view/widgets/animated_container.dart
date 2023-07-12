import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onboarding_performance/models/onboard_performance.dart';
import 'package:shebalin/src/theme/app_color.dart';

class AnimatedBottomSheet extends StatelessWidget {
  const AnimatedBottomSheet({
    super.key,
    required this.child,
    required this.needMoreSpace,
  });

  final Widget child;
  final bool needMoreSpace;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: needMoreSpace
          ? MediaQuery.of(context).size.height * 0.29
          : MediaQuery.of(context).size.height * 0.26,
      duration: const Duration(milliseconds: 300),
      child: Container(
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
      ),
    );
  }
}
