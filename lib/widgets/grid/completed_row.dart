import 'package:flutter/material.dart';
import 'package:wordle_fa_pa/widgets/grid/cell.dart';

class CompletedRow extends StatelessWidget {
  final String guess;
  const CompletedRow({Key? key, required this.guess}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var splitGuess = guess.split('');

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        for (var guess in splitGuess) Cell(value: guess),
      ]),
    );
  }
}
