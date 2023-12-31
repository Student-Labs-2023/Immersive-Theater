import 'package:flutter/material.dart';

class AnimatedVisibility extends StatefulWidget {
  final Widget child;
  final bool isVisible;
  final Duration duration;
  final Curve curve;
  const AnimatedVisibility({
    super.key,
    required this.child,
    required this.isVisible,
    required this.duration,
    required this.curve,
  });

  @override
  State<AnimatedVisibility> createState() => _AnimatedVisibilityState();
}

class _AnimatedVisibilityState extends State<AnimatedVisibility>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late final Animation<double> animation;
  bool get isVisible => widget.isVisible;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: isVisible ? 1.0 : 0.0,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: widget.curve,
    );

    super.initState();
  }

  @override
  void didUpdateWidget(covariant AnimatedVisibility oldWidget) {
    if (oldWidget.isVisible != widget.isVisible) {
      if (isVisible) {
        controller.forward();
      } else {
        controller.reverse();
      }
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
    return IgnorePointer(
      ignoring: !isVisible,
      child: SizeTransition(
        sizeFactor: animation,
        child: FadeTransition(
          opacity: animation,
          child: widget.child,
        ),
      ),
    );
  }
}
