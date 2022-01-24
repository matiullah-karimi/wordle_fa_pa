import 'dart:math';

import 'package:wordle_fa_pa/data/wordslist.dart';
import 'package:wordle_fa_pa/types/enum_types.dart';

bool isWordInWordList(String word, AppLang lang) {
  return getWordsByLang(lang).contains(word.toLowerCase());
}

getWordsByLang(AppLang language) {
  if (language == AppLang.english) return kEnglishWords;
  if (language == AppLang.persian) return kPersianWords;
  if (language == AppLang.pashto) return kPashtoWords;
}

String getRandomWord(AppLang lang) {
  final _random = Random();
  final list = getWordsByLang(lang);

  return list[_random.nextInt(list.length)].toUpperCase();
}
