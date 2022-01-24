import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle_fa_pa/state/app_lang.dart';
import 'package:wordle_fa_pa/utils/words.dart';

final wordProvider = StateNotifierProvider<WordNotifier, String>((ref) {
  final lang = ref.watch(appLangProvider);

  return WordNotifier(getRandomWord(lang), ref);
});

class WordNotifier extends StateNotifier<String> {
  WordNotifier(String state, this.ref) : super(state);
  Ref ref;
  void change() {
    state = getRandomWord(ref.read(appLangProvider));
  }
}
