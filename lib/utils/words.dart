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

bool isWinningWord(String word, AppLang lang) {
  return getWordOfDay(lang) == word;
}

String getWordOfDay(AppLang lang) {
  // January 1, 2022 Game Epoch
  const epochMs = 1641013200000;
  var now = DateTime.now();
  const msInDay = 86400000;
  var index = ((now.millisecondsSinceEpoch - epochMs) / msInDay).floor();

  return getWordsByLang(lang)[index].toUpperCase();
}
