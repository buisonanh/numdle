import 'package:equatable/equatable.dart';
import 'package:numdle/numdle/numdle.dart';

class Number extends Equatable{
  const Number({required this.letters});

  factory Number.fromString(String number) =>
      Number(letters: number.split('').map((e) => Letter(val: e)).toList());

  final List<Letter> letters;

  String get wordString() => letters.map((e) => e.val).join();

  void addLetter(String val) {
    final currentIndex = letters.indexWhere((e) => e.val.isEmpty);
    if (currentIndex != -1) {
      letters[currentIndex] = Letter(val: val);
    }
  }

  void removeLetter() {
    final recentLetterIndex = letters.lastIndexWhere((e) => e.val.isNotEmpty);
    if (recentLetterIndex != -1) {
      letters[recentLetterIndex] = Letter.empty();
    }
  }

  @override
  List<Object?> get props => [letters];
}