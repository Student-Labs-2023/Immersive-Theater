import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/theme.dart';
import 'package:shebalin/src/theme/ui/app_button.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonTitle;
  const OnboardingPage(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Placeholder(),
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
                      BorderRadius.vertical(top: Radius.circular(40))),
              child: Column(children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Text(subtitle,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.grey,
                        )),
                AppButton(
                    onButtonClickFunction: () => {},
                    buttonTitle: buttonTitle,
                    width: 200,
                    height: 100)
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
