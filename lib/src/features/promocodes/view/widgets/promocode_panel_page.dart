import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shebalin/src/features/promocodes/bloc/tickets_state.dart';
import 'package:shebalin/src/features/promocodes/view/widgets/promocode_screen.dart';
import 'package:shebalin/src/features/promocodes/view/widgets/zero_promocode_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../theme/theme.dart';
import '../../bloc/tickets_bloc.dart';
import 'input_promocode_panel_page.dart';

class PromocodePanelPage extends StatefulWidget {
  const PromocodePanelPage({super.key});

  @override
  State<PromocodePanelPage> createState() => _PromocodePanelPageState();
}

class _PromocodePanelPageState extends State<PromocodePanelPage> {
  final PanelController _panelController = PanelController();
  final TicketsBloc _ticketsBloc = TicketsBloc();
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
                    width: 50,
                  ),
                ),
                panel: SingleChildScrollView(
                  child: InputPromocodePanelPage(bloc: _ticketsBloc),
                ),
                body: BlocBuilder<TicketsBloc, TicketsState>(
                  bloc: _ticketsBloc,
                  builder: (context, state) => state.tickets.isEmpty
                      ? ZeroPromocodeScreen(controller: _panelController)
                      : ListView(
                          children: state.tickets,
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
