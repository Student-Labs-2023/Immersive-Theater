import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< HEAD
import 'package:shebalin/src/features/promocodes/bloc/tickets_bloc.dart';
import 'package:shebalin/src/features/promocodes/bloc/tickets_state.dart';
=======
import 'package:shebalin/src/features/promocodes/view/own_promocodes_screen.dart';
import 'package:shebalin/src/features/promocodes/view/widgets/zero_promocode_page.dart';
>>>>>>> 1925eaa (fixing promocode-screen issues)
import 'package:shebalin/src/features/user/view/widgets/ticket.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../performances/bloc/performance_bloc.dart';
import '../../../performances/view/widgets/performance_card.dart';
import 'input_promocode_panel_page.dart';

class PromocodeScreen extends StatefulWidget {
  PromocodeScreen({Key? key}) : super(key: key);
  static const routeName = '/promocode-screen';
  dynamic tickets;
  @override
  State<PromocodeScreen> createState() => _PromocodeScreenState();
}

class _PromocodeScreenState extends State<PromocodeScreen> {
  final PanelController _panelController = PanelController();
  @override
  Widget build(BuildContext context) {
    final TicketsBloc _ticketsBloc = TicketsBloc();
    return SlidingUpPanel(
        borderRadius: panelRadius,
        backdropEnabled: true,
        parallaxEnabled: true,
        parallaxOffset: 0.05,
        controller: _panelController,
        defaultPanelState: PanelState.CLOSED,
        minHeight: 0,
        maxHeight: MediaQuery.of(context).size.height * 0.3,
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
<<<<<<< HEAD
        child: const SizedBox(
          height: 3,
          width: 50,
        ),
      ),
      panel: InputPromocodePanelPage(bloc: _ticketsBloc,),
      body: Center(
        child: Column(
                  children: [
                    const SizedBox(
                      width: 24,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset(ImagesSources.ticketOutline),
                            const SizedBox(
                              height: 24,
                            ),
                            Text(
                              'У вас еще нет билетов',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: Colors.black.withOpacity(0.3)),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: (() => _panelController.open()),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(accentTextColor),
                            elevation: MaterialStateProperty.all(0),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(
                              const Size(328, 48),
                            ),
                          ),
                          child: Text(
                            'Активировать промокод',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      
    );
=======
        panel: InputPromocodePanelPage(),
        body: widget.tickets == null
            ? ZeroPromocodeScreen(
                panelController: _panelController,
              )
            : BlocBuilder<PerformanceBloc, PerformanceState>(
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
                    return const Text(
                      'Oops...Something went wrong!',
                    );
                  }
                },
              ));
>>>>>>> 1925eaa (fixing promocode-screen issues)
  }
}
