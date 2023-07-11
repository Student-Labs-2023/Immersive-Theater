import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onboarding_performance/models/onboard_performance.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/onboarding_page.dart';
import 'package:shebalin/src/theme/theme.dart';

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

  @override
  void initState() {
    pages = OnboardPerformance.list;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: SafeArea(
          key: Key(currentIndex.toString()),
          child: Image.asset(
            width: double.infinity,
            pages[currentIndex].image,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 34),
        child: currentIndex != 0
            ? Button(
                title: pages[currentIndex].buttonTitle,
                onTap: _nextPage,
                textColor: Colors.white,
                backgroundColor: accentTextColor,
                borderColor: accentTextColor,
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
              color: Colors.black.withOpacity(0.12),
            )
            // blurStyle: BlurStyle.solid)
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...List.generate(
                    pages.length,
                    (index) => PageIndicator(
                      count: pages.length,
                      isActive: index == currentIndex,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              AnimatedSwitcher(
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
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                pages[currentIndex].subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.grey,
                    ),
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

  Widget _buttonsFirstPage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Button(
          title: pages[currentIndex].buttonTitle,
          onTap: _nextPage,
          textColor: Colors.white,
          backgroundColor: accentTextColor,
          borderColor: accentTextColor,
        ),
        const SizedBox(
          height: 16,
        ),
        Button(
          title: "Доберусь сам",
          onTap: _nextPage,
          textColor: Colors.black,
          backgroundColor: Colors.white,
          borderColor: Colors.amber,
        ),
      ],
    );
  }

  void _nextPage() {
    setState(() {
      currentIndex += 1;
    });
  }
}
