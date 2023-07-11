import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onboarding_performance/models/onboard_performance.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/onboarding_page.dart';

class OnboardingPerformance extends StatefulWidget {
  const OnboardingPerformance({super.key});
  final bool listenAtHome = false;
  static const routeName = '/onboarding-performance';

  @override
  State<OnboardingPerformance> createState() => _OnboardingPerformanceState();
}

class _OnboardingPerformanceState extends State<OnboardingPerformance> {
  late final List<OnboardPerformance> pages;
  late final PageController pagecontroller;

  @override
  void initState() {
    pagecontroller = PageController();
    pages = OnboardPerformance.list;

    super.initState();
  }

  @override
  void dispose() {
    pagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: PageView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index) => OnboardingPage(
          onboardInfo: pages[index],
          pageController: pagecontroller,
        ),
        controller: pagecontroller,
      ),
    );
  }
}
