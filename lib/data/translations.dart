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
  'help_title_english': 'How to play',
  'help_title_persian': 'نحوه بازی',
  'help_title_pashto': 'څنګه لوبه وکړو',
  'help_guess_english': 'Bulky',
  'help_guess_persian': 'فرهنگ',
  'help_guess_pashto': 'خوږمن',
  'help_solution_english': 'Daily',
  'help_solution_persian': 'فارسی',
  'help_solution_pashto': 'پشتون',
  'help_desc_english':
      'Guess the WORDLE in 6 tries. After each guess, the color of the tiles will change to show how close your guess was to the word.',
  'help_desc_persian':
      'کلمه را در 6 تلاش حدس بزنید. پس از هر حدس، رنگ کاشی ها تغییر می کند تا نشان دهد حدس شما چقدر به کلمه نزدیک است',
  'help_desc_pashto':
      'په 6 هڅه کې کلمه اټکل کړئ. د هرې اندازې وروسته، د ټایلونو رنګ به بدل شي ترڅو وښيي چې ستاسو اټکل د کلمې سره څومره نږدې و.',
  'help_correct_english':
      'The letter Y is in the word and in the correct spot.',
  'help_correct_persian': 'حرف «ف» در کلمه و در محل صحیح است',
  'help_correct_pashto': 'د  «ن»  توری په کلمه او سم ځای کې دی.',
  'help_present_english': 'The letter L is in the word but in the wrong spot.',
  'help_present_persian': 'حرف «ر» در کلمه است اما در مکان اشتباه است',
  'help_present_pashto': 'د «و» توری په کلمه کې دی مګر په غلط ځای کې.',
  'help_absent_english': 'The letters B, U, K are not in the word in any spot.',
  'help_absent_persian': 'حروف «ه، ن، گ» در کلمه وجود ندارند',
  'help_absent_pashto': 'د «خ، ږ، م» توري په کلمه کې په هیڅ ځای کې ندي.',
};

String translate(String key, AppLang lang) {
  return translations[key + '_' + lang.name.toLowerCase()] ?? key;
}
