import 'package:flutter/material.dart';
import 'package:numdle/numdle/numdle.dart';

enum GameStatus { playing, submitting, lost, won }

class NumdleScreen extends StatefulWidget {
  const NumdleScreen({super.key});

  @override
  _NumdleScreenState createState() => _NumdleScreenState();
}

class _NumdleScreenState extends State<NumdleScreen> {
  GameStatus _gameStatus = GameStatus.playing;

  final List<Number> _board = List.generate(
    6,
    (_) => Number(letters: List.generate(5, (_) => Letter.empty())),
  );

  int _currentNumberIndex = 0;
  
  Number? get _currentNumber => 
      _currentNumberIndex < _board.length ? _board[_currentNumberIndex] : null;

  Number _solution = Number.fromString(
    fiveLetterNumbers[Random().nextInt(fiveLetterNumbers.length)].toUpperCase(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'NUMDLE',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Board(board: _board),
        ],
      ),
    );
  }
}