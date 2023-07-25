import 'package:flutter/material.dart';
import 'package:shebalin/src/features/mode_performance/view/performance_mode_page.dart';
import 'package:shebalin/src/features/onboarding_performance/models/onboard_performance.dart';
import 'package:shebalin/src/features/onboarding_performance/view/onboarding_performance_args.dart';
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

class OnboardingPerformance extends StatefulWidget {
  const OnboardingPerformance({
    super.key,
  });
  final Point startPoint = const Point(
    latitude: 54.988707,
    longitude: 73.368659,
  );
  static const routeName = '/onboarding-rules';

  @override
  State<OnboardingPerformance> createState() => _OnboardingPerformanceState();
}

class _OnboardingPerformanceState extends State<OnboardingPerformance> {
  late List<OnboardPerformance> pages;
  int currentIndex = 0;
  bool get curIndexLessLastindex => currentIndex < pages.length - 1;
  bool get showOneButtonAtHome => currentIndex != 0 || listenAtHome;
  late bool listenAtHome;
  @override
  void didChangeDependencies() {
    final OnboardingPerformanceArgs args =
        ModalRoute.of(context)!.settings.arguments as OnboardingPerformanceArgs;
    listenAtHome = args.listenAtHome;
    pages = listenAtHome ? OnboardPerformance.home : OnboardPerformance.outside;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteBackground,
      body: AnimatedImage(image: pages[currentIndex].image),
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
              PageIndicator(count: pages.length, currentIndex: currentIndex),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 34),
                child: showOneButtonAtHome
                    ? AppIconButton.primaryButton(
                        title: pages[currentIndex].buttonTitle,
                        onTap: curIndexLessLastindex
                            ? _nextPage
                            : _openPerfModeScreen,
                        icon: ImagesSources.right,
                      )
                    : OnboardControllButton(
                        titlePrimary: pages[currentIndex].buttonTitle,
                        onTapPrimary: listenAtHome ? _nextPage : _launchUrl,
                        titleSecondary: 'Доберусь сам',
                        onTapSecondary: curIndexLessLastindex
                            ? _nextPage
                            : _openPerfModeScreen,
                      ),
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
    final linkYandexMap = "http://maps.yandex.ru/?text=$latitude,$longitude";
    if (!await launchUrl(Uri.parse(linkYandexMap))) {
      return;
    }
  }

  void _openPerfModeScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      PerformanceModePage.routeName,
      (route) => false,
    );
  }
}
