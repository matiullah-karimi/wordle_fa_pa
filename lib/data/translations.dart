import 'package:wordle_fa_pa/types/enum_types.dart';

const translations = {
  'try_english': 'Try',
  'try_persian': 'امتحان',
  'try_pashto': 'هڅه',
  'reset_english': 'reset',
  'reset_persian': 'امتحان دوباره',
  'reset_pashto': 'بیا هڅه',
  'lose_english': 'You lost, the word was ',
  'lose_persian': 'شما بازی را باختید، کلمه صحیح بود:',
  'lose_pashto': 'تاسو له لاسه ورکړ، کلمه وه',
  'win_english': 'Congratualtions!, you guessed the word correctly',
  'win_persian': 'تبریک، شما کلمه را درست حدس زدید',
  'win_pashto': 'مبارکۍ!، تاسو کلمه سمه اټکل کړې',
};

String translate(String key, AppLang lang) {
  return translations[key + '_' + lang.name.toLowerCase()] ?? key;
}
