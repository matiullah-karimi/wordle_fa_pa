import 'package:flutter/material.dart';
import 'package:wordle_fa_pa/utils/status.dart';

class Cell extends StatefulWidget {
  final String? value;
  final CharStatus? status;

  const Cell({
    Key? key,
    this.status,
    this.value,
  }) : super(key: key);

  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  Color color = Colors.grey.shade100;

  @override
  initState() {
    fillColors();
    super.initState();
  }

  fillColors() async {
    await Future.delayed(const Duration(milliseconds: 300));

    setState(() {
      if (widget.status == CharStatus.correct) {
        color = Colors.green.shade600;
      } else if (widget.status == CharStatus.present) {
        color = Colors.orange.shade600;
      } else if (widget.status == CharStatus.absent) {
        color = Colors.grey.shade600;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
      width: 40,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
      child: Center(
        child: Text(
          widget.value ?? '',
          style: TextStyle(
            color: widget.status != null ? Colors.grey.shade100 : Colors.black,
          ),
        ),
      ),
    );
  }
}
