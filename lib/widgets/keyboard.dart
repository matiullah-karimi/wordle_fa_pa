import 'package:flutter/material.dart';
import 'package:wordle_fa_pa/data/keyboard.dart';
import 'package:wordle_fa_pa/widgets/keyboard/key.dart';

class Keyboard extends StatelessWidget {
  final Function(String char) onChar;
  final List<String> guesses;
  final String language;

  const Keyboard({
    Key? key,
    required this.guesses,
    required this.onChar,
    required this.language,
  }) : super(key: key);

  getKeyboardByLang() {
    if (language == 'en') {
      return kEnglishKeys;
    }

    return kPersianKeys;
  }

  @override
  Widget build(BuildContext context) {
    List<Row> keyboardLines = [];

    for (var line in getKeyboardByLang()) {
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

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: keyboardLines,
      ),
    );
  }
}
