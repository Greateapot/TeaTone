import 'package:flutter/material.dart';

class BlinkingText extends StatefulWidget {
  const BlinkingText(this.data, {super.key, this.style});

  final String data;
  final TextStyle? style;

  @override
  State<BlinkingText> createState() => _BlinkingTextState();
}

class _BlinkingTextState extends State<BlinkingText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Text(
        widget.data,
        style: widget.style,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
