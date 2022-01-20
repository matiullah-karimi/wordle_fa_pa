import 'package:wordle_fa_pa/types/enum_types.dart';

Map<int, CharStatus> getGuessStatus(String guess, String solution) {
  Map<int, CharStatus> result = {};
  var takenIndexes = {};

  for (int i = 0; i < guess.length; i++) {
    takenIndexes[i] = false;
  }

  for (int i = 0; i < guess.length; i++) {
    if (solution[i] == guess[i]) {
      result[i] = CharStatus.correct;
      takenIndexes[i] = true;
    }

    if (!solution.contains(guess[i])) {
      result[i] = CharStatus.absent;
    }

    if (solution.contains(guess[i]) && !takenIndexes[i]) {
      result[i] = CharStatus.present;
    }
  }

  return result;
}
