import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../theme/images.dart';
import '../../../../theme/theme.dart';

class ZeroPromocodeScreen extends StatelessWidget {
  ZeroPromocodeScreen({super.key, required this.panelController});
  var panelController = PanelController();
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 5,
            ),
            Column(
              children: [
                Image.asset(ImagesSources.ticketOutline),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'У вас еще нет билетов',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.black.withOpacity(0.3)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: (() => panelController.open()),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(accentTextColor),
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
                'Ввести промокод',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      );
  }
}