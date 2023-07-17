import 'package:flutter/material.dart';

class TAnimatedIcon extends StatefulWidget {
  final AnimatedIconData animatedIconData;
  final Duration duration;
  final bool Function() condition;
  const TAnimatedIcon({
    super.key,
    required this.animatedIconData,
    required this.duration,
    required this.condition,
  });

  @override
  State<TAnimatedIcon> createState() => _TAnimatedIconState();
}

class _TAnimatedIconState extends State<TAnimatedIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final CurvedAnimation animation;

  bool Function() get condition => widget.condition;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInBack,
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TAnimatedIcon oldWidget) {
    if (!condition()) {
      controller.forward();
    } else {
      controller.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedIcon(
      icon: widget.animatedIconData,
      progress: animation,
    );
  }
}
