import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/features/detailed_performaces/view/performance_double_screen.dart';
import 'package:shebalin/src/features/performances/bloc/performance_bloc.dart';
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
          context
              .read<PerformanceBloc>()
              .add(PerformanceLoadFullInfo(performance.id));
          Navigator.of(context).pushNamed(
            PerformanceDoubleScreen.routeName,
            arguments: performance,
          );
        },
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color.fromARGB(255, 248, 249, 251),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 239, 240, 242),
                spreadRadius: 2,
                offset: Offset(0, 0),
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height * 0.34,
          width: MediaQuery.of(context).size.width * 0.91,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      height: MediaQuery.of(context).size.height * 0.177,
                      //not 0.18 because bottom overflow
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
                      child: InkWell(
                        borderRadius: BorderRadius.circular(7),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.168,
                          height: MediaQuery.of(context).size.height * 0.033,
                          decoration: BoxDecoration(
                            color: AppColor.blackText,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Text(
                            "299Р",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: AppColor.whiteText),
                            textHeightBehavior: const TextHeightBehavior(
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 0, 4),
                child: Text(
                  performance.title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Image.asset(
                      ImagesSources.timeGrey,
                    ),
                  ),
                  Text(
                    durationToHoursMinutes(
                      performance.info.duration,
                    ).toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColor.greyText),
                    textHeightBehavior: const TextHeightBehavior(
                        leadingDistribution: TextLeadingDistribution.even),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Image.asset(
                      ImagesSources.location,
                      height: 18,
                      width: 18,
                    ),
                  ),
                  Text(
                    performance.info.chapters[0].place.address,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColor.greyText),
                    textHeightBehavior: const TextHeightBehavior(
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  )
                ],
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
