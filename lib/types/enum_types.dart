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
}
