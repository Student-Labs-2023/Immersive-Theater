import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shebalin/src/features/promocodes/view/widgets/promocode_screen.dart';
import 'package:shebalin/src/features/user/view/widgets/ticket.dart';
import 'package:shebalin/src/theme/theme.dart';

import '../../../performances/bloc/performance_bloc.dart';
import '../../../performances/view/widgets/performance_card.dart';
import '../../../user/view/widgets/ticket.dart';
import '../../bloc/tickets_bloc.dart';
import '../../bloc/tickets_event.dart';

class InputPromocodePanelPage extends StatefulWidget {
  InputPromocodePanelPage({Key? key, required this.bloc}) : super(key: key);
  TicketsBloc bloc;
  @override
  State<InputPromocodePanelPage> createState() =>
      _InputPromocodePanelPageState();
}

class _InputPromocodePanelPageState extends State<InputPromocodePanelPage> {
  final _inputTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerformanceBloc, PerformanceState>(
        builder: (context, state) {
      if (state is PerformanceLoadSuccess) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 48, 0, 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(right: 52),
              child: Text(
                'Введите промокод',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            Container(
              height: 40,
              width: 328,
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: searchBarRadius,
              ),
              child: Row(
                children: [
                  const Padding(padding: EdgeInsets.only(left: 12)),
                  Expanded(
                    child: TextField(
                      controller: _inputTextController,
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: bodySmallFontSize,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'XXXX-XXXX-XXXX-XXXX',
                        hintStyle:
                            Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => widget.bloc.add(
                AddTicket(
                  PerformanceCard(
                    performance: state.perfomances.first,
                  ),
                ),
              ),
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
                'Применить',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
            )
          ]),
        );
      } else {
        return CircularProgressIndicator(
          color: accentTextColor,
        );
      }
    });
  }
}


// ElevatedButton(
//                 onPressed: () => bloc.add(
//                   AddTicket(
//                     PerformanceCard(
//                       performance: state.perfomances.first,
//                     ),
//                   ),