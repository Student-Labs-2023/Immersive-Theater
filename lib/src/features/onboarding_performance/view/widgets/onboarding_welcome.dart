import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/app.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_image.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_subtitle.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/app_icon_button.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';

const routePrefixPerfMode = '/perf/';

class OnboardWelcome extends StatelessWidget {
  static const routeName = 'welcome';
  final Performance performance;
  final void Function(bool listenAtHome) onOnboardWelcomeComplete;
  const OnboardWelcome({
    super.key,
    required this.performance,
    required this.onOnboardWelcomeComplete,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CurrentPerformance(performance: performance),
      child: Scaffold(
        backgroundColor: AppColor.accentBackground,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Column(
            children: [
              const AnimatedImage(image: ImagesSources.onboardWelcome),
              const SizedBox(
                height: 16,
              ),
              Text(
                '«${performance.title}',
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
            onTapPrimary: () => onOnboardWelcomeComplete(false),
            onTapSecondary: () => onOnboardWelcomeComplete(true),
          ),
        ),
      ),
    );
  }
}
