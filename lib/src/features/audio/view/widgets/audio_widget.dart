import 'package:flutter/material.dart';
import 'package:shebalin/src/features/audio/view/widgets/circle_progress.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/ui/audio_image.dart';

class AudioWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final String duration;
  final double height;
  final bool isCurrent;
  final bool isPlaying;
  final VoidCallback onTap;
  const AudioWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.duration,
    required this.height,
    required this.isCurrent,
    required this.isPlaying,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: isCurrent
              ? CustomPaint(
                  foregroundPainter: const CircleProgress(
                    color: AppColor.whiteBackground,
                    progress: 0.3,
                  ),
                  child: AudioImage(imageLink: image, size: height),
                )
              : AudioImage(imageLink: image, size: height),
        ),
        const SizedBox(
          width: 14,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              subtitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColor.greyText),
            ),
          ],
        ),
        const SizedBox(
          width: 96,
        ),
        Text(
          duration,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColor.greyText),
        )
      ],
    );
  }
}
