import 'package:flutter/material.dart';
import 'package:wordle_fa_pa/types/enum_types.dart';
import 'package:wordle_fa_pa/utils/words.dart';
import 'package:wordle_fa_pa/widgets/grid/completed_row.dart';
import 'package:wordle_fa_pa/widgets/grid/current_row.dart';
import 'package:wordle_fa_pa/widgets/grid/empty_row.dart';

class Grid extends StatelessWidget {
  final List<String> guesses;
  final String currentGuess;
  final AppLang language;

  const Grid({
    Key? key,
    required this.guesses,
    required this.currentGuess,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var empties = guesses.length < 5 ? List.filled(5 - guesses.length, {}) : [];
    String solution = getWordOfDay(language)['solution'];

    return Container(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        children: [
          for (var guess in guesses)
            CompletedRow(
              guess: guess,
              language: language,
              solution: solution,
            ),
          if (guesses.length < 6) CurrentRow(guess: currentGuess),
          for (var _ in empties) const EmptyRow(),
        ],
      ),
    );
  }
}
