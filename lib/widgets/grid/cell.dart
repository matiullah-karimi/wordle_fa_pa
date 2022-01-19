import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final String? value;
  final String? status;

  const Cell({
    Key? key,
    this.status,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4)),
      child: Center(child: Text(value ?? '')),
    );
  }
}
