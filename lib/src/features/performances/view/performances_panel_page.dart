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

enum KindOfPerfomance { all, composers, actors, painters }

class _PerformancesPanelPageState extends State<PerformancesPanelPage> {
  Enum selectedTitle = KindOfPerfomance.all;
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Padding(padding: EdgeInsets.only(left: 16)),
                  TextButton(
                    onPressed: () => _changeTitleNimber(
                      currentKindOfPerfomance: KindOfPerfomance.all,
                    ),
                    child: Text(
                      "Все",
                      style: selectedTitle == KindOfPerfomance.all
                          ? Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 20)
                          : Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 20,
                                color: secondaryTextColor,
                              ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _changeTitleNimber(
                      currentKindOfPerfomance: KindOfPerfomance.composers,
                    ),
                    child: Text(
                      "Композиторы",
                      style: selectedTitle == KindOfPerfomance.composers
                          ? Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 20)
                          : Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 20,
                                color: secondaryTextColor,
                              ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _changeTitleNimber(
                      currentKindOfPerfomance: KindOfPerfomance.actors,
                    ),
                    child: Text(
                      "Актеры",
                      style: selectedTitle == KindOfPerfomance.actors
                          ? Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 20)
                          : Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 20,
                                color: secondaryTextColor,
                              ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _changeTitleNimber(
                      currentKindOfPerfomance: KindOfPerfomance.painters,
                    ),
                    child: Text(
                      "Художники",
                      style: selectedTitle == KindOfPerfomance.painters
                          ? Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 20)
                          : Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 20,
                                color: secondaryTextColor,
                              ),
                    ),
                  ),
                ],
              ),
            ),
            selectedTitle == KindOfPerfomance.all ||
                    selectedTitle == KindOfPerfomance.composers
                ? BlocBuilder<PerformanceBloc, PerformanceState>(
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
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  _changeTitleNimber({required Enum currentKindOfPerfomance}) {
    if (selectedTitle == currentKindOfPerfomance) return;
    setState(() {
      selectedTitle = currentKindOfPerfomance;
    });
  }
}
