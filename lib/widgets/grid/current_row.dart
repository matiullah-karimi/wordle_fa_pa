import 'package:flutter/material.dart';
import 'package:wordle_fa_pa/widgets/grid/cell.dart';

class CurrentRow extends StatelessWidget {
  final String guess;

  const CurrentRow({Key? key, required this.guess}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var splitGuess = guess.split('');
    var emptyCells = List.filled(5 - splitGuess.length, {});

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        for (var guess in splitGuess) Cell(value: guess),
        for (var _ in emptyCells) const Cell()
      ]),
    );
  }
}
