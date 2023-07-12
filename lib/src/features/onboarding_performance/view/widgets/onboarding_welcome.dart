import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_image.dart';
import 'package:shebalin/src/theme/images.dart';

class OnboardWelcome extends StatelessWidget {
  const OnboardWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AnimatedImage(image: ImagesSources.onboardHeadPhones),
        ],
      ),
    );
  }
}
