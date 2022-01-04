import 'package:flutter/material.dart';

class LinearProgress extends StatefulWidget {
  final double percentage;

  final Color backgroundColor;

  ///Color de la barra que muestra el progreso
  final Color foregroundColor;
  const LinearProgress(
      {Key? key,
      required this.percentage,
      this.foregroundColor = Colors.blue,
      this.backgroundColor = Colors.grey})
      : super(key: key);

  @override
  _LinearProgressState createState() => _LinearProgressState();
}

class _LinearProgressState extends State<LinearProgress>
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
  void didUpdateWidget(covariant LinearProgress oldWidget) {
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
    return Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: 10,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
                painter: _MyCustomProgressIndicator(
                    percentage: (finalPercentage - initialPercentage) *
                            (_controller.value) +
                        initialPercentage,
                    foregroundColor: widget.foregroundColor,
                    backgroundColor: widget.backgroundColor,
                    strokeWidth: 10));
          },
        ));
  }
}

class _MyCustomProgressIndicator extends CustomPainter {
  final double percentage;
  final Color backgroundColor;
  final Color foregroundColor;
  final double strokeWidth;

  const _MyCustomProgressIndicator(
      {required this.percentage,
      required this.foregroundColor,
      required this.backgroundColor,
      required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = backgroundColor
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset.zero, Offset(size.width, 0), paint);

    final paintBar = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = foregroundColor
      ..style = PaintingStyle.stroke;

    if (percentage != 0) {
      canvas.drawLine(
          Offset.zero, Offset(size.width * percentage / 100, 0), paintBar);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
