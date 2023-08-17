import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/onboarding_welcome.dart';
import 'package:shebalin/src/theme/images.dart';

class Ticket extends StatelessWidget {
  const Ticket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openTicketPage(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Stack(
          children: [
            Image.asset(ImagesSources.shebalinTicket),
            Positioned(
              top: 20,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'БИЛЕТ',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.white.withOpacity(0.4)),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Шебалин в Омске',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontSize: 10),
                  )
                ],
              ),
            ),
            Positioned(
              top: 23,
              right: 23,
              child: Image.asset(ImagesSources.barcode),
            )
          ],
        ),
      ),
    );
  }

  void _openTicketPage(BuildContext context) {
    Navigator.of(context).pushNamed(OnboardWelcome.routeName);
  }
}
