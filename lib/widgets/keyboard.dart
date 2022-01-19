import 'package:flutter/material.dart';
import 'package:wordle_fa_pa/data/keyboard.dart';
import 'package:wordle_fa_pa/widgets/keyboard/key.dart';

class Keyboard extends StatelessWidget {
  final Function(String char) onChar;
  final List<String> guesses;
  const Keyboard({Key? key, required this.guesses, required this.onChar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Row> keyboardLines = [];

    for (var line in kEnglishKeys) {
      List<KeyboardKey> keys = [];

      for (var key in line) {
        keys.add(KeyboardKey(
          value: key,
          onClick: (String value) => onChar(value),
        ));
      }

      keyboardLines.add(Row(
        children: keys,
        mainAxisAlignment: MainAxisAlignment.center,
      ));
    }

    return Column(
      children: keyboardLines,
    );
  }
}
