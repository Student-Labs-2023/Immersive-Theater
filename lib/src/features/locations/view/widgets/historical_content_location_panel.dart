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
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Text(
        locationDescription,
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: primaryTextColor, fontSize: 14),
            
      ),
    );
  }
}
