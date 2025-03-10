import 'package:flutter/material.dart';

import '../../../../../shared/utils/const.dart';
import 'circular_percent_painter.dart';

class CircularPercentIndicator extends StatefulWidget {
  final double percent;
  final double radius;
  final double lineWidth;
  final Color fillColor;
  final Color backgroundColor;
  final Color progressColor;
  final TextStyle percentTextStyle;
  final Duration animationDuration;
  final int index;

  const CircularPercentIndicator({
    super.key,
    required this.percent,
    required this.index,
    this.radius = 30.0,
    this.lineWidth = 8.0,
    this.fillColor = Colors.transparent,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.indigo,
    this.percentTextStyle = const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.black54,
    ),
    this.animationDuration = const Duration(milliseconds: 1000),
  }) : assert(percent >= 0 && percent <= 1);

  @override
  CircularPercentIndicatorState createState() =>
      CircularPercentIndicatorState();
}

class CircularPercentIndicatorState extends State<CircularPercentIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CircularPercentPainter(
        percent: widget.percent,
        lineWidth: widget.lineWidth,
        fillColor: widget.fillColor,
        backgroundColor: widget.backgroundColor,
        progressColor: widget.progressColor,
        animation: _animation,
      ),
      child: Padding(
        padding: EdgeInsets.all(widget.lineWidth / 2),
        child: SizedBox(
          height: widget.radius * 2,
          width: widget.radius * 2,
          child: Center(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Text(
                  '${(widget.index * _animation.value).toStringAsFixed(0)}/${(requiredFields).toStringAsFixed(0)}',
                  style: widget.percentTextStyle,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
