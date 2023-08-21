import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shebalin/src/features/promocodes/bloc/tickets_bloc.dart';
import 'package:shebalin/src/features/promocodes/bloc/tickets_state.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'input_promocode_panel_page.dart';

class PromocodePanelPage extends StatefulWidget {
  const PromocodePanelPage({super.key});

  @override
  State<PromocodePanelPage> createState() => _PromocodePanelPageState();
}

class _PromocodePanelPageState extends State<PromocodePanelPage> {
  final PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    final TicketsBloc ticketsBloc = TicketsBloc();
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SlidingUpPanel(
                  borderRadius: panelRadius,
                  backdropEnabled: true,
                  parallaxEnabled: true,
                  parallaxOffset: 0.05,
                  controller: _panelController,
                  defaultPanelState: PanelState.CLOSED,
                  minHeight: 0,
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                  header: Container(
                    margin: const EdgeInsets.fromLTRB(176, 20, 0, 0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.12),
                      borderRadius: containerRadius,
                    ),
                    child: const SizedBox(
                      height: 3,
                      width: 25,
                    ),
                  ),
                  panel: SingleChildScrollView(
                    child: InputPromocodePanelPage(bloc: ticketsBloc),
                  ),
                  body: BlocBuilder<TicketsBloc, TicketsState>(
                    bloc: ticketsBloc,
                    builder: (context, state) => state.tickets.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Center(
                                    child: Image.asset(
                                      ImagesSources.ticketOutline,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    'У вас еще нет билетов',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: secondaryTextColor,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 32),
                                  child: ElevatedButton(
                                    onPressed: (() => _panelController.open()),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        AppColor.purplePrimary,
                                      ),
                                      elevation: MaterialStateProperty.all(0),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      minimumSize: MaterialStateProperty.all(
                                        const Size(328, 48),
                                      ),
                                    ),
                                    child: Text(
                                      'Ввести промокод',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : ListView(
                            children: state.tickets,
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
