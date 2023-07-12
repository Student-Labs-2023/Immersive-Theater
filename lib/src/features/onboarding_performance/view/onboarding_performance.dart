import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onboarding_performance/models/onboard_performance.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/button.dart';
import 'package:shebalin/src/theme/app_color.dart';

import 'widgets/page_indicator.dart';

class OnboardingPerformance extends StatefulWidget {
  const OnboardingPerformance({super.key});
  final bool listenAtHome = false;
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
            ? Button(
                title: pages[currentIndex].buttonTitle,
                onTap: curIndexLessLastindex ? _nextPage : _openPerfModeScreen,
                textColor: AppColor.whiteText,
                backgroundColor: AppColor.purplePrimary,
                borderColor: AppColor.purplePrimary,
              )
            : _buttonsFirstPage(),
      ),
      bottomSheet: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.5,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 44,
              spreadRadius: 0,
              offset: const Offset(0, -12),
              color: AppColor.blackText.withOpacity(0.12),
            )
            // blurStyle: BlurStyle.solid)
          ],
          color: AppColor.whiteBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
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

  Widget _buttonsFirstPage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Button(
          title: pages[currentIndex].buttonTitle,
          onTap: widget.listenAtHome ? _nextPage : _buildRoute,
          textColor: AppColor.whiteText,
          backgroundColor: AppColor.purplePrimary,
          borderColor: AppColor.purplePrimary,
        ),
        const SizedBox(
          height: 16,
        ),
        Button(
          title: "Доберусь сам",
          onTap: curIndexLessLastindex ? _nextPage : _openPerfModeScreen,
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

  void _buildRoute() {}

  void _openPerfModeScreen() {
    // Navigator.of(context).pushReplacementNamed(PerformanceModePage.routeName);
  }
}

class AnimatedImage extends StatelessWidget {
  const AnimatedImage({
    super.key,
    required this.currentIndex,
    required this.pages,
  });

  final int currentIndex;
  final List<OnboardPerformance> pages;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: SafeArea(
        key: Key(currentIndex.toString()),
        child: Image.asset(
          width: double.infinity,
          pages[currentIndex].image,
        ),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.pages,
    required this.currentIndex,
  });

  final List<OnboardPerformance> pages;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ...List.generate(
          pages.length,
          (index) => DotIndicator(
            count: pages.length,
            isActive: index == currentIndex,
          ),
        ),
      ],
    );
  }
}

class AnimatedTitle extends StatelessWidget {
  const AnimatedTitle({
    super.key,
    required this.currentIndex,
    required this.pages,
  });

  final int currentIndex;
  final List<OnboardPerformance> pages;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Text(
        key: Key(currentIndex.toString()),
        textAlign: TextAlign.center,
        pages[currentIndex].title,
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class AnimatedSubtitle extends StatelessWidget {
  const AnimatedSubtitle({
    super.key,
    required this.currentIndex,
    required this.pages,
  });

  final int currentIndex;
  final List<OnboardPerformance> pages;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: RichText(
        key: Key(currentIndex.toString()),
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: pages[currentIndex].subtitle,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColor.greyText,
                  ),
            ),
            TextSpan(
              text: pages[currentIndex].subtitleAccent,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColor.purpleLightPrimary),
            )
          ],
        ),
      ),
    );
  }
}
