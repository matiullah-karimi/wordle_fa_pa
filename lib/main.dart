import 'package:flutter/material.dart';
import 'package:wordle_fa_pa/types/enum_types.dart';
import 'package:wordle_fa_pa/utils/words.dart';
import 'package:wordle_fa_pa/widgets/grid/grid.dart';
import 'package:wordle_fa_pa/widgets/keyboard.dart';
import 'package:wordle_fa_pa/widgets/result.dart';

void main() {
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
  String language = 'en';
  String resultMessage = '';
  MessageType messageType = MessageType.info;
  GameResult gameResult = GameResult.none;

  void onChar(String value) {
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
    });
  }

  void changeLanguage() {
    setState(() {
      if (language == 'en') {
        language = 'fa';
      } else {
        language = 'en';
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
    if (!isWordInWordList(currentGuess, language)) {
      messageType = MessageType.info;
      resultMessage = 'Word does not exist';

      setState(() {});
      return;
    }

    bool winningWord = isWinningWord(currentGuess, language);

    if (currentGuess.length == 5 &&
        guesses.length < 6 &&
        gameResult == GameResult.none) {
      guesses.add(currentGuess);
      currentGuess = '';

      if (winningWord) {
        gameResult = GameResult.win;
        resultMessage = 'You found the word correctly';

        messageType = MessageType.success;
        setState(() {});

        return;
      }

      if (guesses.length == 5) {
        gameResult = GameResult.fail;
        resultMessage = 'You failed to find the word';
        messageType = MessageType.error;
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ResultMessage(
              message: resultMessage,
              type: messageType,
              onClose: () => onResultMessageClose(),
            ),
            Directionality(
              textDirection:
                  language == 'en' ? TextDirection.ltr : TextDirection.rtl,
              child: Grid(
                guesses: guesses,
                currentGuess: currentGuess,
                language: language,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () => onSubmit(),
                  child: const Text('Submit'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Keyboard(guesses: guesses, onChar: onChar, language: language)
          ],
        ),
      ),
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
