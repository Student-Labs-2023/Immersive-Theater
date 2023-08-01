import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/ui/app_placeholer.dart';

class AudioInfoWidget extends StatelessWidget {
  final String performanceTitle;
  final String imageLink;
  final int indexLocation;
  const AudioInfoWidget({
    super.key,
    required this.performanceTitle,
    required this.imageLink,
    required this.indexLocation,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            height: 40,
            width: 40,
            placeholder: (context, url) => const AppProgressBar(),
            imageUrl: imageLink,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              performanceTitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Глава ${indexLocation + 1}',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColor.greyText),
            ),
          ],
        ),
      ],
    );
  }
}
