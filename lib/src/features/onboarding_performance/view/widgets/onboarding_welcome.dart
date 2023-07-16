import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onboarding_performance/view/onboarding_performance.dart';
import 'package:shebalin/src/features/onboarding_performance/view/onboarding_performance_args.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_image.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_subtitle.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/app_icon_button.dart';
import 'package:shebalin/src/theme/images.dart';

class OnboardWelcome extends StatelessWidget {
  static const routeName = '/onboarding-performance';
  const OnboardWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Column(
          children: [
            const AnimatedImage(image: ImagesSources.onboardWelcome),
            const SizedBox(
              height: 16,
            ),
            Text(
              "«Шебалин в Омске»",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 16,
            ),
            const AnimatedSubtitle(
              subtitle:
                  'Перед началом выберите, как вы будете слушать спектакль',
              subtitleAccent: '',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 34),
        child: OnboardControllButton(
          titlePrimary: 'Прослушивание в городе',
          titleSecondary: 'Свободное прослушивание',
          onTapPrimary: () => Navigator.of(context).pushReplacementNamed(
            OnboardingPerformance.routeName,
            arguments: OnboardingPerformanceArgs(
              listenAtHome: false,
            ),
          ),
          onTapSecondary: () => Navigator.of(context).pushReplacementNamed(
            OnboardingPerformance.routeName,
            arguments: OnboardingPerformanceArgs(
              listenAtHome: true,
            ),
          ),
        ),
      ),
    );
  }
}
