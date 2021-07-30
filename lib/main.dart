import 'package:desings_app/src/pages/animations_page.dart';
// import 'package:desings_app/src/pages/headers_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Diseños APP',
        home: AnimationsPage());
  }
}
