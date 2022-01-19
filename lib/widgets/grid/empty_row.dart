import 'package:flutter/material.dart';
import 'package:wordle_fa_pa/widgets/grid/cell.dart';

class EmptyRow extends StatelessWidget {
  const EmptyRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emptyCells = List.filled(5, {});

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [for (var cell in emptyCells) const Cell()],
      ),
    );
  }
}
