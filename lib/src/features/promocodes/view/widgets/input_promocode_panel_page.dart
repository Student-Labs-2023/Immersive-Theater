import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shebalin/src/theme/theme.dart';

import 'package:shebalin/src/features/performances/bloc/performance_bloc.dart';
import 'package:shebalin/src/features/performances/view/widgets/performance_card.dart';
import 'package:shebalin/src/features/promocodes/bloc/tickets_bloc.dart';
import 'package:shebalin/src/features/promocodes/bloc/tickets_event.dart';

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
            padding: const EdgeInsets.only(right: 16, left: 16, top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Промокод',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.914,
                  margin: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: searchBarRadius,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _inputTextController,
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 10,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 1,
                              ),
                            ),
                            hintText: 'XXXX-XXXX-XXXX-XXXX',
                            alignLabelWithHint: mounted,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
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
                  height: 32,
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
                    minimumSize: MaterialStateProperty.all(
                      Size(
                        MediaQuery.of(context).size.width * 0.914,
                        MediaQuery.of(context).size.height * 0.06,
                      ),
                    ),
                  ),
                  child: Text(
                    'Применить промокод',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        } else {
          return CircularProgressIndicator(
            color: accentTextColor,
          );
        }
      },
    );
  }
}
