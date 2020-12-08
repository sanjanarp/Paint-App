import 'package:flutter/material.dart';
import 'package:paint/paint_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paint',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.teal
      ),
      home: PaintScreen(),

    );
  }
}

