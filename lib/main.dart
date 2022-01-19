import 'package:flutter/material.dart';
import 'package:wordle_fa_pa/utils/words.dart';
import 'package:wordle_fa_pa/widgets/grid/grid.dart';
import 'package:wordle_fa_pa/widgets/keyboard.dart';

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
  bool isGameWon = false;
  bool isGameLost = false;

  void _incrementCounter() {
    setState(() {});
  }

  void onChar(String value) {
    if (currentGuess.length < 5 && guesses.length < 6) {
      setState(() {
        currentGuess = currentGuess + value;
      });
    }
  }

  void onDelete() {
    if (currentGuess.isEmpty) return;

    setState(() {
      currentGuess = currentGuess.substring(0, currentGuess.length - 1);
    });
  }

  void onSubmit() {
    if (!isWordInWordList(currentGuess)) {
      // word is not in words list
    }

    bool winningWord = isWinningWord(currentGuess);

    if (currentGuess.length == 5 && guesses.length < 6 && !isGameWon) {
      setState(() {
        guesses.add(currentGuess);
        currentGuess = '';
      });

      if (winningWord) {
        setState(() {
          isGameWon = true;
        });

        return;
      }

      if (guesses.length == 5) {
        setState(() {
          isGameLost = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('Game Lost: ' + isGameLost.toString()),
            Text('Game Won: ' + isGameWon.toString()),
            Grid(guesses: guesses, currentGuess: currentGuess),
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
            Keyboard(guesses: guesses, onChar: onChar)
          ],
        ),
      ),
    );
  }
}
