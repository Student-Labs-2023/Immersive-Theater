import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';

class ReviewTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const ReviewTextField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 8,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: AppColor.accentBackground,
        label: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColor.lightGray),
        ),
      ),
    );
  }
}
