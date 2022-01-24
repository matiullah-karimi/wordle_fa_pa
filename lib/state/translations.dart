import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle_fa_pa/data/translations.dart';
import 'package:wordle_fa_pa/state/app_lang.dart';

final translationProvider = Provider.family<String, String>((ref, key) {
  final lang = ref.watch(appLangProvider);

  return translate(key, lang);
});
