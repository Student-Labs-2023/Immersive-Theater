import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shebalin/src/features/audio/view/widgets/circle_progress.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';

class AudioWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final String duration;

  final bool isCurrent;

  final double progress;
  final VoidCallback onTap;
  const AudioWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.duration,
    required this.isCurrent,
    required this.onTap,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          AudioImageBack(
            height: MediaQuery.of(context).size.height * 0.18 / 3,
            image: image,
            colorFilter: isCurrent
                ? ColorFilter.mode(
                    AppColor.blackText.withOpacity(0.5),
                    BlendMode.color,
                  )
                : null,
            child: isCurrent
                ? CustomPaint(
                    painter: CircleProgress(
                      color: AppColor.whiteBackground.withOpacity(0.4),
                      progress: 1,
                    ),
                    foregroundPainter: CircleProgress(
                      color: AppColor.whiteBackground,
                      progress: progress,
                    ),
                    child: Image.asset(
                      ImagesSources.rectangle,
                    ),
                  )
                : null,
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
          const Spacer(),
          Text(
            duration,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColor.greyText),
          )
        ],
      ),
    );
  }
}

class AudioImageBack extends StatelessWidget {
  const AudioImageBack({
    super.key,
    required this.height,
    required this.image,
    required this.child,
    required this.colorFilter,
  });

  final double height;
  final String image;
  final Widget? child;
  final ColorFilter? colorFilter;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: CachedNetworkImageProvider(image),
          fit: BoxFit.cover,
          colorFilter: colorFilter,
        ),
      ),
      child: child,
    );
  }
}
