import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/theme.dart';
import 'package:shebalin/src/theme/ui/app_text_header.dart';

class HeaderContentLocationPanel extends StatelessWidget {
  const HeaderContentLocationPanel({
    super.key,
    required this.locationTitle,
    required this.locationTag,
  });
  final String locationTitle;
  final String locationTag;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextHeader(title: locationTitle),
          const SizedBox(
            height: 4,
          ),
          Text(
            locationTag,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: secondaryTextColor),
          ),
        ],
      ),
    );
  }
}
