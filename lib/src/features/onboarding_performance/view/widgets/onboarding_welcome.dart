import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_image.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_subtitle.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_title.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/button.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';

class OnboardWelcome extends StatelessWidget {
  const OnboardWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Column(
          children: [
            const AnimatedImage(image: ImagesSources.onboardHeadPhones),
            SizedBox(
              height: 16,
            ),
            Text(
              "«Шебалин в Омске»",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            AnimatedSubtitle(
                subtitle:
                    'Перед началом выберите, как вы будете слушать спектакль',
                subtitleAccent: ''),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 34),
        child: OnboardControllButton(
          titlePurple: 'Прослушивание в городе',
          titleWhite: 'Свободное прослушивание',
          onTapPurple: _onTapPurple,
          onTapWhite: _onTapWhite,
        ),
      ),
    );
  }

  void _onTapPurple() {}

  void _onTapWhite() {}
}
