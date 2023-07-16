import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';

class Tip extends StatelessWidget {
  const Tip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      constraints: BoxConstraints(
        maxHeight: 100,
        maxWidth: MediaQuery.of(context).size.width - 30,
      ),
      child: Row(
        children: [
          const ImageIcon(
            AssetImage(ImagesSources.tipIcon),
            size: 45,
          ),
          Flexible(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Если вы дошли до следующей точки нажмите ",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextSpan(
                    text: "Продолжить",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColor.purplePrimary,
                          fontWeight: FontWeight.w700,
                        ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
