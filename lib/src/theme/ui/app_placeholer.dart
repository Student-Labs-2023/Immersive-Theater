import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';

class AppProgressBar extends StatelessWidget {
  const AppProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: AppColor.lightGray.withOpacity(0.3)),
    );
  }
}
