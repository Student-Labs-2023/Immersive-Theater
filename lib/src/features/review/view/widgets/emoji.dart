import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmojiWidget extends StatelessWidget {
  final bool isActive;
  final String icon;
  const EmojiWidget({
    super.key,
    required this.isActive,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
      scale: isActive ? 1 : 0.8,
      child: Opacity(
        opacity: isActive ? 1 : 0.4,
        child: SvgPicture.asset(
          icon,
          width: 60,
        ),
      ),
    );
  }
}
