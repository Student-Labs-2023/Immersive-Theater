import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';

class BarIndicator extends StatelessWidget {
  const BarIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 4,
        width: 32,
        decoration: BoxDecoration(
          color: AppColor.lightGray,
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }
}
