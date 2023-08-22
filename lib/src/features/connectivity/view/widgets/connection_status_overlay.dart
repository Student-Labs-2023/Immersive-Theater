
import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';

class ConnectionStatusOverlay extends StatefulWidget {
  const ConnectionStatusOverlay({
    super.key,
    required this.topPaddingHeight,
  });

  final double topPaddingHeight;

  @override
  State<ConnectionStatusOverlay> createState() =>
      _ConnectionStatusOverlayState();
}

class _ConnectionStatusOverlayState extends State<ConnectionStatusOverlay>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _position;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    _position =
        Tween<Offset>(begin: const Offset(0.0, -4.0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.ease),
    );
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      left: 0,
      child: SlideTransition(
        position: _position,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColor.destructiveAlertDialog,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: widget.topPaddingHeight,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  textAlign: TextAlign.center,
                  'Нет соединения с интернетом',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColor.whiteText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
