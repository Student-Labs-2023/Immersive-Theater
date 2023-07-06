import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/theme.dart';

class HistoricalContentLocationPanel extends StatelessWidget {
  const HistoricalContentLocationPanel({
    super.key,
    required this.locationDescription,
  });
  final String locationDescription;
  @override
  Widget build(BuildContext context) {
    return Text(
      locationDescription,
      style: Theme.of(context)
          .textTheme
          .labelSmall
          ?.copyWith(color: primaryTextColor),
    );
  }
}
