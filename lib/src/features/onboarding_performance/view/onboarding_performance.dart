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
  int index = 0;

  @override
  void initState() {
    pages = OnboardPerformance.list;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingPage(onboardInfo: pages[index]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 34),
        child: index != 0
            ? Button(
                title: pages[index].buttonTitle,
                onTap: _nextPage,
              )
            : _buttonsFirstPage(),
      ),
    );
  }

  Widget _buttonsFirstPage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Button(
          title: pages[index].buttonTitle,
          onTap: _nextPage,
        ),
        const SizedBox(
          height: 16,
        ),
        Button(
          title: pages[index].buttonTitle,
          onTap: _nextPage,
        ),
      ],
    );
  }

  void _nextPage() {
    setState(() {
      index += 1;
    });
  }
}
