import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/theme.dart';

class BarIndicator extends StatelessWidget {
  const BarIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 6,
        width: 32,
        decoration: BoxDecoration(
          color: barIndicatorColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
