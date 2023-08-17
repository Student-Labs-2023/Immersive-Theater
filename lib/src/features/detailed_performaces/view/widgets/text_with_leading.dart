import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';

class TextWithLeading extends StatelessWidget {
  final String title;
  final String leading;
  const TextWithLeading({
    super.key,
    required this.title,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(leading),
        const SizedBox(
          width: 4,
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: AppColor.greyText),
        )
      ],
    );
  }
}
