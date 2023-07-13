import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onboarding_performance/models/onboard_performance.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_container.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_image.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_subtitle.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_title.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/app_icon_button.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'widgets/page_indicator.dart';

class OnboardingPerfRules extends StatefulWidget {
  const OnboardingPerfRules({
    super.key,
  });
  final Point startPoint = const Point(
    latitude: 54.988707,
    longitude: 73.368659,
  );
  static const routeName = '/onboarding-rules';

  @override
  State<OnboardingPerfRules> createState() => _OnboardingPerfRulesState();
}

class _OnboardingPerfRulesState extends State<OnboardingPerfRules> {
  late final List<OnboardPerformance> pages;
  int currentIndex = 0;
  bool get curIndexLessLastindex => currentIndex < pages.length - 1;
  bool get showOneButtonAtHome => currentIndex != 0 || listenAtHome;
  late final bool listenAtHome;
  @override
  @override
  void didChangeDependencies() {
    listenAtHome = ModalRoute.of(context)!.settings.arguments as bool;
    pages = listenAtHome ? OnboardPerformance.home : OnboardPerformance.outside;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteBackground,
      body: AnimatedImage(image: pages[currentIndex].image),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 34),
        child: showOneButtonAtHome
            ? AppIconButton.purpleButton(
                title: pages[currentIndex].buttonTitle,
                onTap: curIndexLessLastindex ? _nextPage : _openPerfModeScreen,
                icon: ImagesSources.right,
              )
            : OnboardControllButton(
                titlePurple: pages[currentIndex].buttonTitle,
                onTapPurple: listenAtHome ? _nextPage : _launchUrl,
                titleWhite: 'Доберусь сам',
                onTapWhite:
                    curIndexLessLastindex ? _nextPage : _openPerfModeScreen,
              ),
      ),
      bottomSheet: AnimatedBottomSheet(
        needMoreSpace: !showOneButtonAtHome,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            16,
            16,
            16,
            0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PageIndicator(pages: pages, currentIndex: currentIndex),
              const SizedBox(
                height: 40,
              ),
              AnimatedTitle(title: pages[currentIndex].title),
              const SizedBox(
                height: 16,
              ),
              AnimatedSubtitle(
                subtitle: pages[currentIndex].subtitle,
                subtitleAccent: pages[currentIndex].subtitleAccent,
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _nextPage() {
    setState(() {
      currentIndex += 1;
    });
  }

  Future<void> _launchUrl() async {
    final latitude = widget.startPoint.latitude;
    final longitude = widget.startPoint.longitude;
    final linkYandexMap =
        "http://maps.yandex.ru/?text=${latitude},${longitude}";
    if (!await launchUrl(Uri.parse(linkYandexMap))) {
      return;
    }
  }

  void _openPerfModeScreen() {
    // Navigator.of(context).pushReplacementNamed(PerformanceModePage.routeName);
  }
}
