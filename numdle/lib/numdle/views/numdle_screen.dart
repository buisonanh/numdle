import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:numdle/app/app_colors.dart';
import 'package:numdle/numdle/data/number_list.dart';
import 'package:numdle/numdle/numdle.dart';

enum GameStatus { playing, submitting, lost, won }

class NumdleScreen extends StatefulWidget {
  const NumdleScreen({Key? key}) : super(key: key);

  @override
  _NumdleScreenState createState() => _NumdleScreenState();
}

class _NumdleScreenState extends State<NumdleScreen> {
  GameStatus _gameStatus = GameStatus.playing;

  final List<Number> _board = List.generate(
    6,
    (_) => Number(letters: List.generate(5, (_) => Letter.empty())),
  );

  final List<List<GlobalKey<FlipCardState>>> _flipCardKeys = List.generate(
    6,
    (_) => List.generate(5, (_) => GlobalKey<FlipCardState>()),
  );

  int _currentNumberIndex = 0;
  
  Number? get _currentNumber => 
      _currentNumberIndex < _board.length ? _board[_currentNumberIndex] : null;

  Number _solution = Number.fromString(
    fiveLetterNumbers[Random().nextInt(fiveLetterNumbers.length)].toUpperCase(),
  );

  final Set<Letter> _keyboardLetters = {};

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
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Board(board: _board, flipCardKeys: _flipCardKeys),
          const SizedBox(height: 80),
          Keyboard(
            onKeyTapped: _onKeyTapped,
            onDeleteTapped: _onDeleteTapped,
            onEnterTapped: _onEnterTapped,
            letters: _keyboardLetters,
          ),
        ],
      ),
    );
  }

  void _onKeyTapped(String val) {
    if (_gameStatus == GameStatus.playing) {
      setState(() => _currentNumber?.addLetter(val));
    }
  }
  
  void _onDeleteTapped() {
    if (_gameStatus == GameStatus.playing) {
      setState(() => _currentNumber?.removeLetter());
    }
  }

  Future<void> _onEnterTapped() async {
    if (_gameStatus == GameStatus.playing &&
        _currentNumber != null &&
        !_currentNumber!.letters.contains(Letter.empty())) {
      _gameStatus = GameStatus.submitting;

      for (var i = 0; i < _currentNumber!.letters.length; i++) {
        final currentNumberLetter = _currentNumber!.letters[i];
        final currentSolutionLetter = _solution.letters[i];

        setState(() {
          if (currentNumberLetter == currentSolutionLetter) {
            _currentNumber!.letters[i] =
                currentNumberLetter.copyWith(status: LetterStatus.correct);
          } else if (_solution.letters.contains(currentNumberLetter)) {
            _currentNumber!.letters[i] =
                currentNumberLetter.copyWith(status: LetterStatus.inNumber);
          } else {
            _currentNumber!.letters[i] =
                currentNumberLetter.copyWith(status: LetterStatus.notInNumber);
          }
        });

        final letter = _keyboardLetters.firstWhere(
          (e) => e.val == currentNumberLetter.val,
          orElse: () => Letter.empty(),
        );
        if (letter.status != LetterStatus.correct) {
          _keyboardLetters.removeWhere((e) => e.val == currentNumberLetter.val);
          _keyboardLetters.add(_currentNumber!.letters[i]);
        }

        await Future.delayed(
          const Duration(milliseconds: 150),
          () => _flipCardKeys[_currentNumberIndex][i].currentState?.toggleCard(),
        );
      }

      _checkIfWinOrLoss();
    }
  }

  void _checkIfWinOrLoss() {
    if (_currentNumber!.wordString == _solution.wordString) {
      _gameStatus = GameStatus.won;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.none,
          duration: const Duration(days: 1),
          backgroundColor: correctColor,
          content: const Text(
            'You won!',
            style: TextStyle(color: Colors.white),
          ),
          action: SnackBarAction(
            onPressed: _restart,
            textColor: Colors.white,
            label: 'New Game',
          ),
        ),
      );
    } else if (_currentNumberIndex + 1 >= _board.length) {
      _gameStatus = GameStatus.lost;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.none,
          duration: const Duration(days: 1),
          backgroundColor: Colors.redAccent[200],
          content: Text(
            'You lost!          Solution: ${_solution.wordString}',
            style: const TextStyle(color: Colors.white),
          ),
          action: SnackBarAction(
            onPressed: _restart,
            textColor: Colors.white,
            label: 'New Game',
          ),
        ),
      );
    } else {
      _gameStatus = GameStatus.playing;
    }
    _currentNumberIndex += 1;
  }

  void _restart() {
    setState(() {
      _gameStatus = GameStatus.playing;
      _currentNumberIndex = 0;
      _board
        ..clear()
        ..addAll(
          List.generate(
            6,
            (_) => Number(letters: List.generate(5, (_) => Letter.empty())),
          ),
        );
      _solution = Number.fromString(
        fiveLetterNumbers[Random().nextInt(fiveLetterNumbers.length)].toUpperCase(),
      );
      _flipCardKeys
        ..clear()
        ..addAll(
          List.generate(
            6,
            (_) => List.generate(5, (_) => GlobalKey<FlipCardState>()),
          ),
        );
      _keyboardLetters.clear();
    });
  }
}