import 'package:flutter/material.dart';
import 'package:wordle_fa_pa/utils/status.dart';

class Cell extends StatelessWidget {
  final String? value;
  final CharStatus? status;

  const Cell({
    Key? key,
    this.status,
    this.value,
  }) : super(key: key);

  Color getColor() {
    Color color = Colors.grey.shade100;

    if (status == CharStatus.correct) {
      color = Colors.green.shade600;
    } else if (status == CharStatus.present) {
      color = Colors.orange.shade600;
    } else if (status == CharStatus.absent) {
      color = Colors.grey.shade600;
    }

    return color;
  }

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
        borderRadius: BorderRadius.circular(4),
        color: getColor(),
      ),
      child: Center(
        child: Text(
          value ?? '',
          style: TextStyle(
            color: status != null ? Colors.grey.shade100 : Colors.black,
          ),
        ),
      ),
    );
  }
}
