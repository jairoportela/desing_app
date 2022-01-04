// import 'dart:math';
// import 'dart:ui';

// import 'package:flutter/material.dart';

// class CircularProgressPage extends StatefulWidget {
//   const CircularProgressPage({Key? key}) : super(key: key);

//   @override
//   _CircularProgressPageState createState() => _CircularProgressPageState();
// }

// class _CircularProgressPageState extends State<CircularProgressPage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;

//   @override
//   void initState() {
//     controller = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 500));
//     super.initState();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           padding: const EdgeInsets.all(4),
//           width: 300,
//           height: 300,
//           child: CustomPaint(painter: _MyCustomProgressIndicator(percentage)),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => setState(() {
//           percentage = percentageNew;
//           if (percentageNew < 100) {
//             percentageNew += 10;
//           } else {
//             percentageNew = 0;
//             percentage = 0;
//           }
//           controller.forward(from: 0);
//         }),
//         child: const Icon(Icons.refresh),
//       ),
//     );
//   }
// }

// class _MyCustomProgressIndicator extends CustomPainter {
//   final double percentage;

//   const _MyCustomProgressIndicator(this.percentage);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..strokeWidth = 5
//       ..color = Colors.grey
//       ..style = PaintingStyle.stroke;

//     final Offset c = Offset(size.width * 0.5, size.height * 0.5);
//     final double radius = min(size.width * 0.5, size.height * 0.5);

//     canvas.drawCircle(c, radius, paint);

//     final paintArco = Paint()
//       ..strokeWidth = 10
//       ..color = Colors.red
//       ..style = PaintingStyle.stroke;

//     double arcAngle = 2 * pi * (percentage / 100);

//     canvas.drawArc(Rect.fromCircle(center: c, radius: radius), 3 * pi / 2,
//         arcAngle, false, paintArco);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
