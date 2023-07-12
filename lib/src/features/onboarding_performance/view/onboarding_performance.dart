import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onboarding_performance/models/onboard_performance.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_container.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_image.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_subtitle.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_title.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/button.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'widgets/page_indicator.dart';

class OnboardingPerformance extends StatefulWidget {
  const OnboardingPerformance({
    super.key,
  });
  final bool listenAtHome = false;
  final Point startPoint = const Point(
    latitude: 54.988707,
    longitude: 73.368659,
  );
  static const routeName = '/onboarding-performance';

  @override
  State<OnboardingPerformance> createState() => _OnboardingPerformanceState();
}

class _OnboardingPerformanceState extends State<OnboardingPerformance> {
  late final List<OnboardPerformance> pages;
  int currentIndex = 0;
  bool get curIndexLessLastindex => currentIndex < pages.length - 1;
  bool get showOneButtonAtHome => currentIndex != 0 || widget.listenAtHome;
  @override
  void initState() {
    pages = widget.listenAtHome
        ? OnboardPerformance.home
        : OnboardPerformance.outside;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteBackground,
      body: AnimatedImage(currentIndex: currentIndex, pages: pages),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 34),
        child: showOneButtonAtHome
            ? Button.purpleButton(
                title: pages[currentIndex].buttonTitle,
                onTap: curIndexLessLastindex ? _nextPage : _openPerfModeScreen,
                icon: ImagesSources.right,
              )
            : _twoButtons(),
      ),
      bottomSheet: AnimatedBottomSheet(
        pages: pages,
        currentIndex: currentIndex,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PageIndicator(pages: pages, currentIndex: currentIndex),
              const SizedBox(
                height: 40,
              ),
              AnimatedTitle(currentIndex: currentIndex, pages: pages),
              const SizedBox(
                height: 16,
              ),
              AnimatedSubtitle(currentIndex: currentIndex, pages: pages),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _twoButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Button.purpleButton(
          title: pages[currentIndex].buttonTitle,
          onTap: widget.listenAtHome ? _nextPage : _launchUrl,
          icon: ImagesSources.right,
        ),
        const SizedBox(
          height: 16,
        ),
        Button(
          title: "Доберусь сам",
          onTap: curIndexLessLastindex ? _nextPage : _openPerfModeScreen,
          icon: ImagesSources.right,
          textColor: AppColor.blackText,
          backgroundColor: AppColor.whiteBackground,
          borderColor: AppColor.yellowSecondary,
        ),
      ],
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
