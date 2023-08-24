import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';

class AppCircleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String tag;
  final String image;
  const AppCircleButton({
    super.key,
    required this.onPressed,
    required this.tag,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: tag,
      backgroundColor: AppColor.whiteBackground,
      onPressed: onPressed,
      child: Image(
        image: AssetImage(image),
      ),
    );
  }
}
