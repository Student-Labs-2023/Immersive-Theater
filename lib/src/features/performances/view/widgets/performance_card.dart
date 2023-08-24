import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/features/detailed_performaces/view/detailed_performance_args.dart';
import 'package:shebalin/src/features/detailed_performaces/view/detailed_performance_page.dart';
import 'package:shebalin/src/features/detailed_performaces/view/widgets/text_with_leading.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';
import 'package:shebalin/src/theme/ui/app_placeholer.dart';

class PerformanceCard extends StatelessWidget {
  const PerformanceCard({
    Key? key,
    required this.performance,
    required this.isTicket,
  }) : super(key: key);
  final Performance performance;
  final bool isTicket;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            DetailedPerformancePage.routeName,
            arguments: DetailedPerformanceArgs(performance: performance),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.accentBackground,
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 239, 240, 242),
                spreadRadius: 2,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      height: MediaQuery.of(context).size.height * 0.18,
                      width: MediaQuery.of(context).size.width * 0.82,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: secondaryColor,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: performance.imageLink,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const AppProgressBar(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8, right: 8),
                      child: isTicket
                          ? const SizedBox()
                          : Price(price: performance.price),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 0, 4),
                child: Text(
                  performance.title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWithLeading(
                          title: durationToHoursMinutes(
                            performance.duration,
                          ).toString(),
                          leading: ImagesSources.timeGrey,
                        ),
                        TextWithLeading(
                          title: performance.info.chapters[0].place.address,
                          leading: ImagesSources.location,
                        ),
                      ],
                    ),
                    isTicket ? const PlayButton() : const SizedBox.shrink()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String durationToHoursMinutes(Duration duration) {
    final int hours = duration.inHours;
    final int minutes = duration.inMinutes - hours * 60;
    return '$hours ч. $minutes мин.';
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFF212529),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateZ(pi / 2),
        child: Container(
          margin: const EdgeInsets.all(14),
          decoration: const ShapeDecoration(
            color: AppColor.whiteBackground,
            shape: StarBorder.polygon(
              pointRounding: 0.3,
              sides: 3,
            ),
          ),
        ),
      ),
    );
  }
}

class Price extends StatelessWidget {
  const Price({
    super.key,
    required this.price,
  });

  final int price;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 70,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.blackText,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          '$price Р',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColor.whiteText,
              ),
        ),
      ),
    );
  }
}
