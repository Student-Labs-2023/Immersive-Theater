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
          Text(
            locationTitle,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 20,),
            child: Text(
            locationTag,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: secondaryTextColor),
          ),
          ),
        ],
      ),
    );
  }
}
