import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final Gradient gradient;

  CirclePainter({required this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paint =
        Paint()
          ..shader = gradient.createShader(
            Rect.fromCircle(center: center, radius: radius),
          )
          ..style = PaintingStyle.fill
          ..blendMode = BlendMode.multiply;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
