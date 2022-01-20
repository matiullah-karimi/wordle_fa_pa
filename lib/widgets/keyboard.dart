import 'package:flutter/material.dart';
import 'package:wordle_fa_pa/data/keyboard.dart';
import 'package:wordle_fa_pa/types/enum_types.dart';
import 'package:wordle_fa_pa/widgets/keyboard/key.dart';

class Keyboard extends StatelessWidget {
  final Function(String char) onChar;
  final List<String> guesses;
  final AppLang language;

  const Keyboard({
    Key? key,
    required this.guesses,
    required this.onChar,
    required this.language,
  }) : super(key: key);

  getKeyboardByLang() {
    if (language == AppLang.english) {
      return kEnglishKeys;
    }

    if (language == AppLang.pashto) {
      return kPashtoKeys;
    }

    return kPersianKeys;
  }

  @override
  Widget build(BuildContext context) {
    List<Row> keyboardLines = [];

    for (var line in getKeyboardByLang()) {
      List<Expanded> keys = [];

      for (var key in line) {
        keys.add(Expanded(
          child: KeyboardKey(
            value: key,
            onClick: (String value) => onChar(value),
          ),
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
