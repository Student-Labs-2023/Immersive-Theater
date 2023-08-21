import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/ui/app_audio_image.dart';

class AudioInfoWidget extends StatelessWidget {
  final String performanceTitle;
  final String imageLink;
  final int indexLocation;
  final int countLocation;
  const AudioInfoWidget({
    super.key,
    required this.performanceTitle,
    required this.imageLink,
    required this.indexLocation,
    required this.countLocation,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppAudioImage(
          imageLink: imageLink,
          size: 40,
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
              'Глава ${indexLocation + 1} / $countLocation',
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
