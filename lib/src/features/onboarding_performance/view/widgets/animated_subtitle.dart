import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/ui/app_subtitle.dart';

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
