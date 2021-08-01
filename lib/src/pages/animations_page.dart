import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationsPage extends StatelessWidget {
  const AnimationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AnimatedSquare(),
      ),
    );
  }
}

class AnimatedSquare extends StatefulWidget {
  const AnimatedSquare({Key? key}) : super(key: key);

  @override
  State<AnimatedSquare> createState() => _AnimatedSquareState();
}

class _AnimatedSquareState extends State<AnimatedSquare>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> rotation;
  late Animation<double> opacityIn;
  late Animation<double> opacityOut;
  late Animation<double> moveRectangle;
  late Animation<double> scaleRectangle;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    rotation = Tween(begin: 0.0, end: math.pi)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    opacityIn = Tween(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.25, curve: Curves.easeIn),
      ),
    );
    moveRectangle = Tween(begin: 0.0, end: 200.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    scaleRectangle = Tween(begin: 0.0, end: 2.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    opacityOut = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 1, curve: Curves.easeOut),
      ),
    );
    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();

    return AnimatedBuilder(
      animation: _controller,
      builder: (ctx, child) {
        return Transform.translate(
          offset: Offset(moveRectangle.value, 0),
          child: Transform.rotate(
            angle: rotation.value,
            child: Opacity(
              opacity: opacityIn.value - opacityOut.value,
              child: Transform.scale(
                scale: scaleRectangle.value,
                child: child,
              ),
            ),
          ),
        );
      },
      child: _Rectangle(),
    );
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
