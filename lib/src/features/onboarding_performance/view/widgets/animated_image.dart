import 'package:flutter/material.dart';

class AnimatedImage extends StatelessWidget {
  const AnimatedImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 111, 8, 0),
        key: Key(image),
        child: Image.asset(
          width: double.infinity,
          image,
        ),
      ),
    );
  }
}
