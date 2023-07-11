import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onboarding_performance/models/onboard_performance.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/page_indicator.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardPerformance onboardInfo;
  const OnboardingPage({
    super.key,
    required this.onboardInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 111, 8, 18),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 3000),
          child: Image.asset(
            width: double.infinity,
            onboardInfo.image,
          ),
        ),
      ),
    );
  }

  void _next() {}
}

class Button extends StatelessWidget {
  final String title;
  final void Function() onTap;

  const Button({
    super.key,
    required this.title,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(accentTextColor),
        elevation: MaterialStateProperty.all(5),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        minimumSize: MaterialStateProperty.all(
          Size(
            MediaQuery.of(context).size.width * 0.85,
            MediaQuery.of(context).size.height * 0.06,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.white),
          ),
          const SizedBox(
            width: 9,
          ),
          const ImageIcon(
            AssetImage(ImagesSources.right),
            color: Colors.white,
            size: 24,
          )
        ],
      ),
    );
  }
}
