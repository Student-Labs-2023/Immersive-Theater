import 'dart:math';

import 'package:flutter/material.dart';

class CircleProgress extends CustomPainter {
  final Color color;
  final double progress;
  const CircleProgress({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = size.height / 10;
    final Paint painter = Paint()
      ..strokeWidth = strokeWidth
      ..color = color
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (size.width - strokeWidth) / 2;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      progress * 2 * pi,
      false,
      painter,
    );
  }

  @override
  bool shouldRepaint(covariant CircleProgress oldDelegate) =>
      oldDelegate.progress != progress;
}
