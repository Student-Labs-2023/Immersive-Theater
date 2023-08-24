import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shebalin/src/features/performances/view/widgets/performance_card.dart';

import 'package:shebalin/src/features/tickets/bloc/ticket_bloc.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';

class PromocodePanelPage extends StatefulWidget {
  const PromocodePanelPage({super.key});

  @override
  State<PromocodePanelPage> createState() => _PromocodePanelPageState();
}

class _PromocodePanelPageState extends State<PromocodePanelPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<TicketBloc, TicketState>(
                builder: (context, state) {
                  if (state is TicketLoadInProgress) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: accentTextColor,
                      ),
                    );
                  }
                  if (state is TicketLoadSuccess) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 15),
                        itemCount: state.tickets.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return PerformanceCard(
                            isTicket: true,
                            performance: state.tickets[index],
                          );
                        },
                      ),
                    );
                  }
                  return Column(
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
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: secondaryTextColor,
                                    ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
