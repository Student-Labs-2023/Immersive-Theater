import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shebalin/src/features/detailed_performaces/view/widgets/bad_audiodemo_example.dart';
import 'package:shebalin/src/features/performances/bloc/performance_bloc.dart';
import 'package:shebalin/src/theme/theme.dart';

class AudioContentLocationPanel extends StatelessWidget {
  const AudioContentLocationPanel({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerformanceBloc, PerformanceState>(
      builder: (context, performanceState) {
        if (performanceState is PerformanceLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(
              color: accentTextColor,
            ),
          );
        }
        if (performanceState is PerformanceLoadSuccess) {
          return BadAudioDemo(
            isBought: false,
            performance: performanceState.perfomances[0],
            index: 0,
          );
        } else {
          return const Text('Что-то не так!');
        }
      },
    );
  }
}
