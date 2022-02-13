import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle_fa_pa/state/app_lang.dart';
import 'package:wordle_fa_pa/state/translations.dart';
import 'package:wordle_fa_pa/state/word.dart';
import 'package:wordle_fa_pa/types/enum_types.dart';
import 'package:wordle_fa_pa/widgets/dialogs/help_dialog.dart';
import 'package:wordle_fa_pa/widgets/grid/grid.dart';
import 'package:wordle_fa_pa/widgets/keyboard.dart';
import 'package:wordle_fa_pa/widgets/flash_message.dart';
import 'package:wordle_fa_pa/widgets/dialogs/language_dialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
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

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  List<String> guesses = [];
  String currentGuess = '';
  String resultMessage = '';
  MessageType messageType = MessageType.info;
  GameResult gameResult = GameResult.none;

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
    ref.read(wordProvider.notifier).change();
    setState(() {
      guesses = [];
      currentGuess = '';
      resultMessage = '';
      gameResult = GameResult.none;
    });
  }

  void changeLanguage() {
    LanguageDialog(
      onItemClicked: (lang) {
        ref.read(appLangProvider.notifier).change(lang);

        clearState();
      },
      context: context,
      currentLang: ref.read(appLangProvider),
    ).show();
    // clearState();
  }

  void onDelete() {
    if (currentGuess.isEmpty) return;

    setState(() {
      currentGuess = currentGuess.substring(0, currentGuess.length - 1);
    });
  }

  void onSubmit() {
    if (currentGuess.isEmpty) return;
    final lang = ref.read(appLangProvider);
    final solution = ref.read(wordProvider);

    bool winningWord = solution == currentGuess;

    if (currentGuess.length == 5 && guesses.length <= 6) {
      guesses.add(currentGuess);
      currentGuess = '';

      if (winningWord) {
        gameResult = GameResult.win;
        resultMessage = ref.read(translationProvider('win'));
        messageType = MessageType.success;
      }

      if (guesses.length == 6 && !winningWord) {
        gameResult = GameResult.fail;
        resultMessage = ref.read(translationProvider('lose')) + ' ' + solution;
        messageType = MessageType.error;
      }
    }

    setState(() {});
  }

  onResultMessageClose() {
    resultMessage = '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final language = ref.watch(appLangProvider);

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
                  Directionality(
                    textDirection: language.direction,
                    child: FlashMessage(
                      message: resultMessage,
                      type: messageType,
                      onClose: () => onResultMessageClose(),
                    ),
                  ),
                  Directionality(
                    textDirection: language.direction,
                    child: Grid(
                      guesses: guesses,
                      currentGuess: currentGuess,
                    ),
                  ),
                  _buildActionButtons(),
                  const SizedBox(height: 16),
                  Keyboard(
                    guesses: guesses,
                    onChar: onChar,
                  ),
                ],
              ),
            ),
          ),
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
        child: Text(ref.read(translationProvider('reset'))),
      );
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: currentGuess.length == 5
            ? Colors.green
            : Colors.green.shade300, // background
        onPrimary: Colors.white, // foreground
      ),
      onPressed: () => currentGuess.length == 5 ? onSubmit() : null,
      child: Text(ref.read(translationProvider('try'))),
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
            onTap: () => HelpDialog(
                    context: context, currentLang: ref.read(appLangProvider))
                .show(),
            child: const Icon(Icons.help),
          ),
        ),
      ],
    );
  }
}
