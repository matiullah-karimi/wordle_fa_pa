import 'package:wordle_fa_pa/data/wordslist.dart';

bool isWordInWordList(String word) {
  return kEnglishWords.contains(word.toLowerCase());
}

bool isWinningWord(String word) {
  print(getWordOfDay()['solution']);
  return getWordOfDay()['solution'] == word;
}

getWordOfDay() {
  // January 1, 2022 Game Epoch
  const epochMs = 1641013200000;
  var now = DateTime.now();
  const msInDay = 86400000;
  var index = ((now.millisecondsSinceEpoch - epochMs) / msInDay).floor();

  return {
    'solution': kEnglishWords[index].toUpperCase(),
    'solutionIndex': index,
  };
}
