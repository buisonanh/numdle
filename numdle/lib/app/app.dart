import 'package:flutter/material.dart';
import 'package:numdle/numdle/views/numdle_screen.dart';

void main() {
  runApp( Numdle() );
}

class Numdle extends StatelessWidget {
  const Numdle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Numdle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Color.fromRGBO(0, 8, 20, 1)),
      home: const NumdleScreen(),
    );
  }
}