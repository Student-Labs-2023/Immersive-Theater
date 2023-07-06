import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shebalin/src/features/performances/bloc/performance_bloc.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../performances/view/widgets/performance_card.dart';
import 'widgets/input_promocode_panel_page.dart';

class OwnPromocodesScreen extends StatelessWidget {
  const OwnPromocodesScreen({Key? key}) : super(key: key);
  static const routeName = '/promocode-screen/own';
  @override
  Widget build(BuildContext context) {
    final PanelController panelController = PanelController();
    return Scaffold(
      body: Scaffold(
        appBar: null,
        body: SlidingUpPanel(
          controller: panelController,
          defaultPanelState: PanelState.CLOSED,
          minHeight: 0,
          maxHeight: MediaQuery.of(context).size.height * 0.25,
          header: Container(
            margin: const EdgeInsets.fromLTRB(176, 20, 0, 0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.12),
              borderRadius: containerRadius,
            ),
            child: const SizedBox(
              height: 3,
              width: 50,
            ),
          ),
          panel: InputPromocodePanelPage(),
          body: Center(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                actions: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    iconSize: 34,
                    icon: Image.asset(ImagesSources.close),
                    splashRadius: 24,
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Center(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 24,
                                ),
                                Text(
                                  'Промокоды',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(fontSize: 31),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
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
                                      itemCount: state.perfomances.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return PerformanceCard(
                                          performance: state.perfomances[index],
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return const Text(
                                    'Oops...Something went wrong!',
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              floatingActionButton: ElevatedButton(
                onPressed: (() => panelController.open()),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(accentTextColor),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(const Size(328, 48)),
                ),
                child: Text(
                  'Активировать промокод',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            ),
          ),
          borderRadius: panelRadius,
          backdropEnabled: true,
          parallaxEnabled: true,
          parallaxOffset: 0.05,
        ),
      ),
    );
  }
}
