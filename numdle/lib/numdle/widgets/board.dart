import 'package:flutter/material.dart';
import 'package:numdle/numdle/numdle.dart';

class Board extends StatelessWidget {
  const Board({
    Key? key,
    required this.board,
  }) : super(key: key);

  final List<Number> board;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: board
          .map(
            (number) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: number.letters
                  .map((letter) => BoardTile(letter: letter))
                  .toList(),
            ),
          )
          .toList(),
    );
  }
}