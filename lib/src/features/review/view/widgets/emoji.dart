import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shebalin/src/features/review/models/emoji.dart';

class Emojies extends StatelessWidget {
  final void Function(int index) onTapEmoji;
  final List<Emoji> emotions;
  const Emojies({
    super.key,
    required this.onTapEmoji,
    required this.emotions,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          emotions.length,
          ((index) => GestureDetector(
                onTap: () => onTapEmoji(index),
                child: _EmojiWidget(
                  key: Key(index.toString()),
                  isActive: emotions[index].isActive,
                  icon: emotions[index].icon,
                ),
              )),
        ),
      ],
    );
  }
}

class _EmojiWidget extends StatelessWidget {
  final bool isActive;
  final String icon;
  const _EmojiWidget({
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
