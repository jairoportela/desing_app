import 'package:flutter/material.dart';
import 'dart:math';

class RadialProgress extends StatefulWidget {
  final double percentage;

  final Color backgroundColor;

  ///Color de la barra que muestra el progreso
  final Color foregroundColor;
  const RadialProgress(
      {Key? key,
      required this.percentage,
      this.foregroundColor = Colors.blue,
      this.backgroundColor = Colors.grey})
      : super(key: key);

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  late double initialPercentage;
  late double finalPercentage;
  late AnimationController _controller;

  @override
  void initState() {
    initialPercentage = 0;
    finalPercentage = widget.percentage;

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _controller.forward(from: 0);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RadialProgress oldWidget) {
    initialPercentage = finalPercentage;
    finalPercentage = widget.percentage;
    _controller.forward(from: 0);

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // LinearProgressIndicator
    return Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
                painter: _MyCustomProgressIndicator(
                    percentage: (finalPercentage - initialPercentage) *
                            (_controller.value) +
                        initialPercentage,
                    foregroundColor: widget.foregroundColor,
                    backgroundColor: widget.backgroundColor));
          },
        ));
  }
}

class _MyCustomProgressIndicator extends CustomPainter {
  final double percentage;
  final Color backgroundColor;
  final Color foregroundColor;

  const _MyCustomProgressIndicator(
      {required this.percentage,
      required this.foregroundColor,
      required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 11
      ..strokeCap = StrokeCap.round
      ..color = backgroundColor
      ..style = PaintingStyle.stroke;

    final Offset c = Offset(size.width * 0.5, size.height * 0.5);
    final double radius = min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(c, radius, paint);

    final paintArco = Paint()
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..color = foregroundColor
      ..style = PaintingStyle.stroke;

    double arcAngle = 2 * pi * (percentage / 100);

    canvas.drawArc(Rect.fromCircle(center: c, radius: radius), 3 * pi / 2,
        arcAngle, false, paintArco);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
