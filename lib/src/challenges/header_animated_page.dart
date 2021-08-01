import "package:flutter/material.dart";

class HeaderAnimatedPage extends StatelessWidget {
  const HeaderAnimatedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _WaveHeader(),
    );
  }
}

class _WaveHeader extends StatelessWidget {
  const _WaveHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderWavePainter(),
      ),
    );
  }
}

class _HeaderWavePainter extends CustomPainter {
  const _HeaderWavePainter();
  @override
  void paint(Canvas canvas, Size size) {
    //Lapiz
    final paint = Paint();

    //Propiedades
    paint.color = const Color(0xff615AAB);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 20;

    final path = Path();

    //Dibujar con el path  y el paint
    path.lineTo(0, size.height * 0.3);

    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * (0.3 + 0.06),
      size.width * 0.5,
      size.height * 0.3,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * (0.3 - 0.06),
      size.width,
      size.height * 0.3,
    );
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
