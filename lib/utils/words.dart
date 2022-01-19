import 'package:wordle_fa_pa/data/wordslist.dart';

bool isWordInWordList(String word, String lang) {
  return getWordsByLang(lang).contains(word.toLowerCase());
}

getWordsByLang(String language) {
  if (language == 'en') return kEnglishWords;
  if (language == 'fa') return kPersianWords;
}

bool isWinningWord(String word, String lang) {
  print(getWordOfDay(lang)['solution']);
  return getWordOfDay(lang)['solution'] == word;
}

getWordOfDay(String lang) {
  // January 1, 2022 Game Epoch
  const epochMs = 1641013200000;
  var now = DateTime.now();
  const msInDay = 86400000;
  var index = ((now.millisecondsSinceEpoch - epochMs) / msInDay).floor();

  return {
    'solution': getWordsByLang(lang)[index].toUpperCase(),
    'solutionIndex': index,
  };
}
