import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';

import '../../../../theme/theme.dart';

class OnbordingContent extends StatelessWidget {
  const OnbordingContent({
    Key? key,
    required this.imageName,
    required this.text,
    required this.title,
  }) : super(key: key);

  final String imageName;
  final String text;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.06),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width * 0.91,
                height: MediaQuery.of(context).size.height * 0.6,
                clipBehavior: Clip.none,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: AppColor.whiteBackground,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    children: [
                      Image(
                        height: MediaQuery.of(context).size.height * 0.34,
                        image: AssetImage(imageName),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            title,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            text,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
