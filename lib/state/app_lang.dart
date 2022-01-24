import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle_fa_pa/types/enum_types.dart';

final appLangProvider = StateNotifierProvider<AppLangNotifier, AppLang>((ref) {
  return AppLangNotifier(AppLang.persian);
});

class AppLangNotifier extends StateNotifier<AppLang> {
  AppLangNotifier(AppLang state) : super(state);

  void change(AppLang lang) {
    state = lang;
  }
}
