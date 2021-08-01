import 'package:flutter/material.dart';

class SquareAnimatedPage extends StatelessWidget {
  const SquareAnimatedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SquareAnimated(),
      ),
    );
  }
}

class SquareAnimated extends StatefulWidget {
  const SquareAnimated({
    Key? key,
  }) : super(key: key);

  @override
  State<SquareAnimated> createState() => _SquareAnimatedState();
}

class _SquareAnimatedState extends State<SquareAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> translationX1;
  late Animation<double> translationX2;
  late Animation<double> translationY1;
  late Animation<double> translationY2;

  Animation<double> _builderTween(
      {required double begin,
      required double end,
      required double intervalBegin,
      required double intervalEnd}) {
    return Tween(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(intervalBegin, intervalEnd, curve: Curves.bounceOut),
      ),
    );
  }

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4500));

    translationX1 = _builderTween(
        begin: 0.0, end: 100.0, intervalBegin: 0, intervalEnd: 0.25);

    translationY1 = _builderTween(
        begin: 0.0, end: -100, intervalBegin: 0.25, intervalEnd: 0.5);

    translationX2 = _builderTween(
        begin: 0.0, end: 100, intervalBegin: 0.5, intervalEnd: 0.75);

    translationY2 = _builderTween(
        begin: 0.0, end: -100, intervalBegin: 0.75, intervalEnd: 1.0);

    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reset();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return AnimatedBuilder(
        animation: _controller,
        child: _Rectangle(),
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              translationX1.value - translationX2.value,
              translationY1.value - translationY2.value,
            ),
            child: child,
          );
        });
  }
}

class _Rectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: const BoxDecoration(color: Colors.blue),
    );
  }
}
