import 'package:flutter/material.dart';

class KeyboardKey extends StatelessWidget {
  final String value;
  final Function(String value) onClick;
  const KeyboardKey({
    Key? key,
    required this.value,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(value),
      child: Container(
        margin: const EdgeInsets.all(2),
        height: 40,
        decoration: BoxDecoration(
          color: value == 'clear' ? Colors.red.shade700 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: value == 'clear'
              ? const Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.white,
                )
              : Text(value),
        ),
      ),
    );
  }
}
