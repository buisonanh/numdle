import 'package:flutter/material.dart';

void main() {
  runApp( Numdle() );
}

class Numdle extends StatelessWidget {
  const Numdle({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Hello Numdle'),
        ),
      ),
    );
  }
}