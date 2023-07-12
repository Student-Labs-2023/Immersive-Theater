import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onboarding_performance/models/onboard_performance.dart';

class AnimatedTitle extends StatelessWidget {
  const AnimatedTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Text(
        key: Key(title),
        textAlign: TextAlign.center,
        title,
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}
