import 'package:flutter/material.dart';
import '../widgets/radial_progress.dart';
import '../widgets/linear_progress.dart';

class GraphicsProgressPage extends StatefulWidget {
  const GraphicsProgressPage({Key? key}) : super(key: key);

  @override
  _GraphicsProgressPageState createState() => _GraphicsProgressPageState();
}

class _GraphicsProgressPageState extends State<GraphicsProgressPage> {
  double percentage = 0;

  changePercentage() {
    if (percentage < 3) {
      setState(() {
        percentage += 1;
      });
    } else {
      setState(() {
        percentage = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        LinearProgress(
          percentage: percentage / 3 * 100,
          foregroundColor: Colors.red,
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0.1),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 300,
          height: 300,
          child: RadialProgress(
            percentage: percentage / 3 * 100,
            foregroundColor: Colors.green,
            backgroundColor: const Color.fromRGBO(0, 0, 0, 0.1),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: changePercentage,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
