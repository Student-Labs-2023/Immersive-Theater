import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../theme/images.dart';
import '../../../../theme/theme.dart';

class ZeroPromocodeScreen extends StatelessWidget {
  const ZeroPromocodeScreen({super.key, required PanelController controller})
      : _panelController = controller;
  final PanelController _panelController;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Center(
              child: Image.asset(ImagesSources.ticketOutline),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'У вас еще нет билетов',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                    MaterialStateProperty.all(AppColor.purplePrimary),
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
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
