import 'package:flutter/material.dart';

import 'screens/board_screen.dart';
import 'screens/time_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: //const TimeScreen(),
      const BoardScreen()
    );
  }
}


