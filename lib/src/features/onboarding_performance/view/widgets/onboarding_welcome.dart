import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shebalin/src/features/mode_performance_flow/models/current_performance_provider.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_image.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_subtitle.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/controll_button.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/ui/app_bar_close.dart';

const routePrefixPerfMode = '/perf/';

class OnboardWelcome extends StatelessWidget {
  static const routeName = 'welcome';
  final void Function(bool listenAtHome) onOnboardWelcomeComplete;
  final VoidCallback onOnboardingClose;
  const OnboardWelcome({
    super.key,
    required this.onOnboardWelcomeComplete,
    required this.onOnboardingClose,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBtnClose(
        icon: ImagesSources.backIcon,
        onPressed: onOnboardingClose,
      ),
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
              '«${RepositoryProvider.of<CurrentPerformanceProvider>(context).performance.title}»',
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
    );
  }
}
