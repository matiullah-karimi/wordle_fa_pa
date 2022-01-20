import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wordle_fa_pa/types/enum_types.dart';
import 'package:wordle_fa_pa/utils/words.dart';
import 'package:wordle_fa_pa/widgets/banner_ad.dart';
import 'package:wordle_fa_pa/widgets/grid/grid.dart';
import 'package:wordle_fa_pa/widgets/keyboard.dart';
import 'package:wordle_fa_pa/widgets/flash_message.dart';
import 'package:wordle_fa_pa/ads/rewarded_ad.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordle Persian',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Wordle Persian & Pashto'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> guesses = [];
  String currentGuess = '';
  AppLang language = AppLang.persian;
  String resultMessage = '';
  MessageType messageType = MessageType.info;
  GameResult gameResult = GameResult.none;
  late GoogleRewardedAd ad;

  @override
  void initState() {
    ad = GoogleRewardedAd().load();

    super.initState();
  }

  showRewardedAd() {
    Future.delayed(const Duration(seconds: 3)).then((value) => ad.show());
  }

  void onChar(String value) {
    if (value == 'clear') {
      onDelete();
      return;
    }

    if (currentGuess.length < 5 && guesses.length < 6) {
      setState(() {
        currentGuess = currentGuess + value;
      });
    }
  }

  void clearState() {
    setState(() {
      guesses = [];
      currentGuess = '';
      resultMessage = '';
      gameResult = GameResult.none;
    });
  }

  void changeLanguage() {
    setState(() {
      if (language == AppLang.english) {
        language = AppLang.persian;
      } else {
        language = AppLang.pashto;
      }
    });

    clearState();
  }

  void onDelete() {
    if (currentGuess.isEmpty) return;

    setState(() {
      currentGuess = currentGuess.substring(0, currentGuess.length - 1);
    });
  }

  void onSubmit() {
    if (currentGuess.isEmpty) return;

    if (!isWordInWordList(currentGuess, language)) {
      messageType = MessageType.info;
      resultMessage = 'Word does not exist';

      setState(() {});
      // return;
    }

    bool winningWord = isWinningWord(currentGuess, language);

    if (currentGuess.length == 5 && guesses.length <= 6) {
      guesses.add(currentGuess);
      currentGuess = '';

      if (winningWord) {
        gameResult = GameResult.win;
        resultMessage = 'You found the word correctly';

        messageType = MessageType.success;
        setState(() {});

        // show rewarded ad
        showRewardedAd();
        return;
      }

      if (guesses.length == 6) {
        gameResult = GameResult.fail;
        resultMessage = 'You failed to find the word';
        messageType = MessageType.error;
        setState(() {});

        // show rewarded ad
        showRewardedAd();
      }
    }
  }

  onResultMessageClose() {
    resultMessage = '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  FlashMessage(
                    message: resultMessage,
                    type: messageType,
                    onClose: () => onResultMessageClose(),
                  ),
                  Directionality(
                    textDirection: language == AppLang.english
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    child: Grid(
                      guesses: guesses,
                      currentGuess: currentGuess,
                      language: language,
                    ),
                  ),
                  _buildActionButtons(),
                  const SizedBox(height: 16),
                  Keyboard(
                    guesses: guesses,
                    onChar: onChar,
                    language: language,
                  ),
                ],
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: BannerAdWidget(),
          )
        ],
      ),
    );
  }

  ElevatedButton _buildActionButtons() {
    if (gameResult != GameResult.none) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue, // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () => clearState(),
        child: const Text('Reset'),
      );
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.green, // background
        onPrimary: Colors.white, // foreground
      ),
      onPressed: () => onSubmit(),
      child: const Text('Submit'),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.grey.shade800,
      elevation: 0,
      title: Text(widget.title),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () => changeLanguage(),
            child: const Icon(
              Icons.language,
              size: 26.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {},
            child: const Icon(Icons.help),
          ),
        ),
      ],
    );
  }
}
