import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/theme.dart';

class AppTextHeader extends StatelessWidget {
  const AppTextHeader({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: primaryTextColor,
            fontWeight: FontWeight.w700,
          ),
      maxLines: 2,
    );
  }
}
