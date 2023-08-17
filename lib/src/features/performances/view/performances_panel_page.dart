import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shebalin/src/theme/theme.dart';

import '../bloc/performance_bloc.dart';
import 'widgets/performance_card.dart';

class PerformancesPanelPage extends StatefulWidget {
  const PerformancesPanelPage({Key? key}) : super(key: key);

  @override
  State<PerformancesPanelPage> createState() => _PerformancesPanelPageState();
}

class _PerformancesPanelPageState extends State<PerformancesPanelPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<PerformanceBloc, PerformanceState>(
              builder: (context, state) {
                if (state is PerformanceLoadInProgress) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: accentTextColor,
                    ),
                  );
                }
                if (state is PerformanceLoadSuccess) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 15),
                      itemCount: state.perfomances.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return PerformanceCard(
                          performance: state.perfomances[index],
                        );
                      },
                    ),
                  );
                } else {
                  return const Text('Oops...Something went wrong!');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
