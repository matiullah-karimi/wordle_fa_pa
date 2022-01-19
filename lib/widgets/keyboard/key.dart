import 'package:flutter/material.dart';

class KeyboardKey extends StatelessWidget {
  final String value;
  final Function(String value) onClick;
  const KeyboardKey({Key? key, required this.value, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(value),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(child: Text(value)),
      ),
    );
  }
}
