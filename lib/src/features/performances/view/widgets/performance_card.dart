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
  const PerformanceCard({Key? key, required this.performance})
      : super(key: key);
  final Performance performance;

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
                      child: FittedBox(
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
                            '${performance.price} Р',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppColor.whiteText,
                                    ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 0, 4),
                child: Text(
                  performance.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
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
