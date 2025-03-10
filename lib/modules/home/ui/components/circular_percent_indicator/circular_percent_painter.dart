import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

class CircularPercentPainter extends CustomPainter {
  final double percent;
  final double lineWidth;
  final Color fillColor;
  final Color backgroundColor;
  final Color progressColor;
  final Animation<double> animation;

  CircularPercentPainter({
    required this.percent,
    required this.lineWidth,
    required this.fillColor,
    required this.backgroundColor,
    required this.progressColor,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - lineWidth) / 2;

    // Background circle
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = lineWidth,
    );

    // Filled circle
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = fillColor
        ..style = PaintingStyle.fill,
    );

    // Arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      radians(-90), // Start at -90 degrees (top)
      radians(
        (360.0 * percent) * animation.value,
      ), // Sweep angle based on percent
      false, // Don't use center
      Paint()
        ..color = progressColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = lineWidth
        ..strokeCap = StrokeCap.round, // Round ends similar to your image
    );
  }

  @override
  bool shouldRepaint(covariant CircularPercentPainter oldDelegate) {
    return oldDelegate.percent != percent ||
        oldDelegate.lineWidth != lineWidth ||
        oldDelegate.fillColor != fillColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.progressColor != progressColor;
  }
}
