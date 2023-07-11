import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onboarding_performance/models/onboard_performance.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/page_indicator.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardPerformance onboardInfo;
  final PageController pageController;
  const OnboardingPage({
    super.key,
    required this.onboardInfo,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 111, 8, 18),
        child: Image.asset(
          width: double.infinity,
          onboardInfo.image,
        ),
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
              PageIndicator(
                count: 3,
                isActive: false,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                textAlign: TextAlign.center,
                onboardInfo.title,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                onboardInfo.subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.grey,
                    ),
              ),
              const SizedBox(
                height: 40,
              ),
              Button(
                onTap: () {},
                title: onboardInfo.buttonTitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
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
      onPressed: () {},
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
