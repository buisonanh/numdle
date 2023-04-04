import 'package:flutter/material.dart';

void main() {
  runApp( Numdle() );
}

class Numdle extends StatelessWidget {
  const Numdle({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Numdle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const NumdleScreen(),
    );
  }
}