import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shebalin/src/features/mode_performance/bloc/mode_performance_bloc.dart';
import 'package:shebalin/src/theme/theme.dart';

class ProgressLocationsBar extends StatelessWidget {
  final int countLocation;
  final int durationPerformance;
  const ProgressLocationsBar({
    super.key,
    required this.countLocation,
    required this.durationPerformance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 63,
      width: 86,
      child: Center(
        child: BlocBuilder<ModePerformanceBloc, ModePerformanceState>(
          builder: (context, state) {
            return RichText(
              text: TextSpan(
                text: state.indexLocation.toString(),
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: accentTextColor,
                      fontWeight: FontWeight.w700,
                    ),
                children: [
                  TextSpan(
                    text: " / ${countLocation.toString()}",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  TextSpan(
                    text: "\n${durationPerformance.toString()} мин",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.black),
                  )
                  //           ?.copyWith(color: Colors.black,)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
