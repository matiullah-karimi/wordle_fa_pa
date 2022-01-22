import 'package:flutter/material.dart';
import 'package:wordle_fa_pa/data/translations.dart';
import 'package:wordle_fa_pa/types/enum_types.dart';
import 'package:wordle_fa_pa/widgets/grid/completed_row.dart';

class HelpDialog {
  final BuildContext context;
  final AppLang currentLang;

  HelpDialog({
    required this.context,
    required this.currentLang,
  });

  Future<void> show() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: currentLang.direction,
          child: SimpleDialog(
            title: Text(translate('help_title', currentLang)),
            contentPadding:
                const EdgeInsets.only(top: 8, bottom: 16, right: 24, left: 24),
            titlePadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            children: <Widget>[
              Text(translate('help_desc', currentLang)),
              const SizedBox(height: 24),
              CompletedRow(
                guess: translate('help_guess', currentLang),
                language: currentLang,
                solution: translate('help_solution', currentLang),
              ),
              Text(translate('help_correct', currentLang)),
              const SizedBox(height: 8),
              Text(translate('help_present', currentLang)),
              const SizedBox(height: 8),
              Text(translate('help_absent', currentLang)),
            ],
          ),
        );
      },
    );
  }
}
