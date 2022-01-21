import 'package:flutter/material.dart';
import 'package:wordle_fa_pa/types/enum_types.dart';

class LanguageDialog {
  final Function(AppLang lang) onItemClicked;
  final BuildContext context;
  final AppLang currentLang;

  LanguageDialog({
    required this.onItemClicked,
    required this.context,
    required this.currentLang,
  });

  Future<void> show() async {
    switch (await showDialog<AppLang>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select Language'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () => _onItemClicked(AppLang.english),
                child: _buildItem(AppLang.english),
              ),
              SimpleDialogOption(
                onPressed: () => _onItemClicked(AppLang.persian),
                child: _buildItem(AppLang.persian),
              ),
              SimpleDialogOption(
                onPressed: () => _onItemClicked(AppLang.pashto),
                child: _buildItem(AppLang.pashto),
              ),
            ],
          );
        })) {
      case AppLang.english:
        // Let's go.
        // ...
        break;
      case AppLang.persian:
        // ...
        break;
      case null:
        // dialog dismissed
        break;
      case AppLang.pashto:
        // TODO: Handle this case.
        break;
    }
  }

  Container _buildItem(AppLang lang) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(
          width: 1,
          color: Colors.grey.shade100,
        ),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(lang.text),
          if (currentLang == lang)
            Icon(
              Icons.check,
              color: Colors.grey.shade700,
            ),
        ],
      ),
    );
  }

  _onItemClicked(AppLang lang) {
    onItemClicked(lang);
    Navigator.pop(context);
  }
}
