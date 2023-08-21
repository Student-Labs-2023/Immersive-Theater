import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';

class AudioDemoSkeleton extends StatelessWidget {
  const AudioDemoSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return const AudioCardSkeleton();
        },
      ),
    );
  }
}

class AudioCardSkeleton extends StatelessWidget {
  const AudioCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.grey.shade100,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    child: Container(
                      color: AppColor.whiteBackground,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 73,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColor.whiteBackground,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 20,
                      width: 134,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColor.whiteBackground,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Container(
              height: 20,
              width: 29,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColor.whiteBackground,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PhotosSkeleton extends StatelessWidget {
  final double photoHeight;
  final double photoWidth;

  const PhotosSkeleton({
    super.key,
    required this.photoHeight,
    required this.photoWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: photoHeight + 10,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (context, index) => const SizedBox(
          width: 8,
        ),
        itemBuilder: (context, index) => Container(
          height: photoHeight,
          width: photoWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColor.whiteBackground,
          ),
        ),
      ),
    );
  }
}

class AuthorsSkeleton extends StatelessWidget {
  const AuthorsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        cacheExtent: 10,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 64,
                minWidth: 200,
                maxHeight: 64,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  color: AppColor.whiteBackground,
                ),
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(right: 12),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DescriptionSkeleton extends StatelessWidget {
  const DescriptionSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColor.whiteBackground,
            borderRadius: BorderRadius.circular(6),
          ),
          width: MediaQuery.of(context).size.width * 0.91,
          height: 19,
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: AppColor.whiteBackground,
            borderRadius: BorderRadius.circular(6),
          ),
          width: MediaQuery.of(context).size.width * 0.91,
          height: 19,
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: AppColor.whiteBackground,
            borderRadius: BorderRadius.circular(6),
          ),
          width: MediaQuery.of(context).size.width * 0.3,
          height: 19,
        ),
      ],
    );
  }
}

class HistoricalContentSkeleton extends StatelessWidget {
  const HistoricalContentSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuerySize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: mediaQuerySize.height * 0.037,
          width: mediaQuerySize.width * 0.91,
          decoration: BoxDecoration(
            color: AppColor.whiteBackground,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: mediaQuerySize.height * 0.037,
          width: mediaQuerySize.width * 0.91,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColor.whiteBackground,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: mediaQuerySize.height * 0.037,
          width: mediaQuerySize.width * 0.91,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColor.whiteBackground,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: mediaQuerySize.height * 0.037,
          width: mediaQuerySize.width * 0.69,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColor.whiteBackground,
          ),
        ),
      ],
    );
  }
}
