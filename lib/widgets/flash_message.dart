import 'package:flutter/material.dart';
import 'package:wordle_fa_pa/types/enum_types.dart';

class FlashMessage extends StatefulWidget {
  final String message;
  final MessageType type;
  final Function onClose;

  const FlashMessage(
      {Key? key,
      required this.message,
      required this.type,
      required this.onClose})
      : super(key: key);

  @override
  State<FlashMessage> createState() => _FlashMessageState();
}

class _FlashMessageState extends State<FlashMessage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double offsetX = 400;
  final tween = Tween<double>(begin: 1.0, end: 0.0);
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    animation = tween.animate(_controller);
  }

  Color get _backgroundColor {
    if (widget.type == MessageType.success) {
      return Colors.green;
    }

    if (widget.type == MessageType.error) {
      return Colors.red;
    }

    if (widget.type == MessageType.info) {
      return Colors.blue;
    }

    if (widget.type == MessageType.warning) {
      return Colors.orange;
    }

    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.message.isEmpty) {
      return const Text('');
    }

    _controller.forward();
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(offsetX * animation.value, 0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: _backgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.message,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: InkWell(
                    onTap: () {
                      _controller.reset();
                      widget.onClose();
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
