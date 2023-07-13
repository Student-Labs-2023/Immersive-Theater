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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.transparent),
        color: AppColor.accentBackground,
      ),
      height: MediaQuery.of(context).size.height * 0.2,
      child: TextField(
        style: Theme.of(context).textTheme.bodyMedium,
        maxLines: double.maxFinite.floor(),
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          alignLabelWithHint: true,
          filled: true,
          fillColor: Colors.transparent,
          label: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColor.lightGray),
          ),
        ),
      ),
    );
  }
}
