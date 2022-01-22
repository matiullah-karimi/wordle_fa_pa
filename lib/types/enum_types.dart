import 'package:flutter/cupertino.dart';

enum GameResult { win, fail, none }
enum MessageType { error, success, info, warning }
enum CharStatus { absent, present, correct }
enum AppLang { english, persian, pashto }

extension AppLangExtension on AppLang {
  String get text {
    switch (this) {
      case AppLang.english:
        return 'English';
      case AppLang.persian:
        return 'فارسی';
      default:
        return 'پشتو';
    }
  }

  String get name {
    switch (this) {
      case AppLang.english:
        return 'English';
      case AppLang.persian:
        return 'Persian';
      default:
        return 'Pashto';
    }
  }

  TextDirection get direction {
    switch (this) {
      case AppLang.english:
        return TextDirection.ltr;
      default:
        return TextDirection.rtl;
    }
  }
}
