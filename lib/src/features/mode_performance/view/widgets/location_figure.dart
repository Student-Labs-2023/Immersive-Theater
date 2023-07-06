import 'package:flutter/material.dart';

class LocationFigure extends CustomPainter {
  final Color color;
  final bool isCurrentLocation;
  final double bias;
  LocationFigure({
    required this.color,
    required this.isCurrentLocation,
    required this.bias,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width / 13.0;

    final radius = (size.width / 5);
    final center = Offset(size.width / 2, radius);
    final painterRing = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, painterRing);
    final startPoint = Offset(center.dx, center.dy + radius + 2);
    final endPoint = Offset(size.width / 2, size.height + bias);
    final painterLine = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawLine(startPoint, endPoint, painterLine);
    if (isCurrentLocation) {
      final painterCircle = Paint()
        ..style = PaintingStyle.fill
        ..color = color
        ..strokeWidth = strokeWidth;
      canvas.drawCircle(center, radius / 2, painterCircle);
    }
  }

  @override
  bool shouldRepaint(covariant LocationFigure oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.isCurrentLocation != isCurrentLocation;
}
