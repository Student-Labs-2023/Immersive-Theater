import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shebalin/src/features/mode_performance_flow/models/current_performance_provider.dart';
import 'package:shebalin/src/features/onboarding_performance/models/onboard_performance.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_container.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_image.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_subtitle.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_title.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/controll_button.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/ui/app_bar_close.dart';
import 'package:shebalin/src/theme/ui/app_button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/page_indicator.dart';

class OnboardingPerformance extends StatefulWidget {
  const OnboardingPerformance({
    super.key,
    required this.listenAtHome,
    required this.onOnboardingComplete,
  });

  final void Function(bool listenAtHome) onOnboardingComplete;
  final bool listenAtHome;

  static const routeName = 'rules';

  @override
  State<OnboardingPerformance> createState() => _OnboardingPerformanceState();
}

class _OnboardingPerformanceState extends State<OnboardingPerformance> {
  late List<OnboardPerformance> pages;
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
      appBar: AppBarBtnClose(
        icon: ImagesSources.backIcon,
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: AppColor.accentBackground,
      body: AnimatedImage(image: pages[currentIndex].image),
      bottomSheet: AnimatedBottomSheet(
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
              PageIndicator(
                count: pages.length,
                currentIndex: currentIndex,
                elementWidth: 8,
                elementHeight: 8,
              ),
              const SizedBox(
                height: 40,
              ),
              AnimatedTitle(title: pages[currentIndex].title),
              const SizedBox(
                height: 16,
              ),
              AnimatedSubtitle(
                subtitle: pages[currentIndex].subtitle,
                subtitleAccent: showOneButtonAtHome
                    ? pages[currentIndex].subtitleAccent
                    : RepositoryProvider.of<CurrentPerformanceProvider>(context)
                        .performance
                        .info
                        .chapters[0]
                        .place
                        .address,
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 34),
                child: showOneButtonAtHome
                    ? AppButton.primaryButton(
                        title: pages[currentIndex].buttonTitle,
                        onTap: curIndexLessLastindex
                            ? _nextPage
                            : () => widget
                                .onOnboardingComplete(widget.listenAtHome),
                      )
                    : OnboardControllButton(
                        titlePrimary: pages[currentIndex].buttonTitle,
                        onTapPrimary:
                            widget.listenAtHome ? _nextPage : _launchUrl,
                        titleSecondary: 'Доберусь сам',
                        onTapSecondary: curIndexLessLastindex
                            ? _nextPage
                            : () => widget
                                .onOnboardingComplete(widget.listenAtHome),
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
    final double latitude =
        RepositoryProvider.of<CurrentPerformanceProvider>(context)
            .performance
            .info
            .chapters[0]
            .place
            .latitude;
    final double longitude =
        RepositoryProvider.of<CurrentPerformanceProvider>(context)
            .performance
            .info
            .chapters[0]
            .place
            .longitude;
    final linkYandexMap = "http://maps.yandex.ru/?text=$latitude,$longitude";
    if (!await launchUrl(Uri.parse(linkYandexMap))) {
      return;
    }
  }
}
