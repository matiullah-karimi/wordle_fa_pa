import 'package:flutter/material.dart';
import 'package:wordle_fa_pa/types/enum_types.dart';
import 'package:wordle_fa_pa/utils/status.dart';
import 'package:wordle_fa_pa/utils/words.dart';
import 'package:wordle_fa_pa/widgets/grid/cell.dart';

class CompletedRow extends StatelessWidget {
  final String guess;
  final AppLang language;

  const CompletedRow({
    Key? key,
    required this.guess,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String solution = getWordOfDay(language)['solution'];

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        for (int i = 0; i < guess.length; i++)
          Cell(
            value: guess[i],
            status: getGuessStatus(guess, solution)[i],
          ),
      ]),
    );
  }
}
