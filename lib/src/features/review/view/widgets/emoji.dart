import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shebalin/src/theme/images.dart';

class Emoji extends StatelessWidget {
  final bool isActive;
  final String icon;
  const Emoji({
    super.key,
    required this.isActive,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isActive ? 1 : 0.4,
      child: SvgPicture.asset(
        icon,
        width: isActive ? 60 : 52,
      ),
    );
  }
}
