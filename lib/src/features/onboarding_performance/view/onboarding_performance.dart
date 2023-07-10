import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/onboarding_page.dart';

class OnboardingPerformance extends StatelessWidget {
  const OnboardingPerformance({super.key});
  static const routeName = '/onboarding-performance';
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: PageView(
          children: const <Widget>[
            OnboardingPage(
              title: 'Используйте наушники во время спектакля',
              subtitle:
                  'Чтобы уменьшить внешний шум и погрузиться в настроение спектакля',
              buttonTitle: 'Далее',
            ),
            OnboardingPage(
              title: 'Используйте наушники во время спектакля',
              subtitle:
                  'Чтобы уменьшить внешний шум и погрузиться в настроение спектакля',
              buttonTitle: 'Далее',
            ),
          ],
        ));
  }
}
