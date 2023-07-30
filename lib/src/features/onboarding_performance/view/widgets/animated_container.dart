import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';

class AnimatedBottomSheet extends StatefulWidget {
  const AnimatedBottomSheet({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<AnimatedBottomSheet> createState() => _AnimatedBottomSheetState();
}

class _AnimatedBottomSheetState extends State<AnimatedBottomSheet>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animationController.forward();
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.whiteBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: SizeTransition(
        sizeFactor: _animation,
        child: AnimatedSize(
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500),
          child: widget.child,
        ),
      ),
    );
  }
}
