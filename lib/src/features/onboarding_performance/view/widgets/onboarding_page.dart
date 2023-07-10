import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonTitle;
  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(child: Image.asset(ImagesSources.onboarding1)),
          const SizedBox(
            height: 39,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 3,
                    color: Colors.black.withOpacity(0.2),
                  )
                  // blurStyle: BlurStyle.solid)
                ],
                color: Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 100, 16, 0),
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(accentTextColor),
                        elevation: MaterialStateProperty.all(5),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all(
                          Size(
                            MediaQuery.of(context).size.width * 0.85,
                            MediaQuery.of(context).size.width * 0.13,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            buttonTitle,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            width: 9,
                          ),
                          const ImageIcon(
                            AssetImage(ImagesSources.continueButton),
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
