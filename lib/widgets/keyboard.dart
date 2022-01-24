import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle_fa_pa/data/keyboard.dart';
import 'package:wordle_fa_pa/state/app_lang.dart';
import 'package:wordle_fa_pa/types/enum_types.dart';
import 'package:wordle_fa_pa/widgets/keyboard/key.dart';

class Keyboard extends ConsumerWidget {
  final Function(String char) onChar;
  final List<String> guesses;

  const Keyboard({
    Key? key,
    required this.guesses,
    required this.onChar,
  }) : super(key: key);

  getKeyboardByLang(AppLang language) {
    if (language == AppLang.english) {
      return kEnglishKeys;
    }

    if (language == AppLang.pashto) {
      return kPashtoKeys;
    }

    return kPersianKeys;
  }

  @override
  Widget build(BuildContext context, ref) {
    List<Row> keyboardLines = [];
    AppLang lang = ref.watch(appLangProvider);

    for (var line in getKeyboardByLang(lang)) {
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
