import 'package:flutter/material.dart';

final class CaseButtonData {
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final IconData? icon;
  final Color? color;
  final Color? backgroundColor;

  const CaseButtonData({
    required this.onPressed,
    this.onLongPress,
    this.icon,
    this.color,
    this.backgroundColor,
  });
}

class CaseButton extends StatelessWidget {
  const CaseButton({super.key, required this.caseButtonData});

  final CaseButtonData caseButtonData;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MaterialButton(
      color: caseButtonData.backgroundColor ?? colorScheme.primary,
      onLongPress: caseButtonData.onLongPress,
      onPressed: caseButtonData.onPressed,
      child: Icon(
        caseButtonData.icon,
        color: caseButtonData.color ?? colorScheme.onPrimary,
      ),
    );
  }
}
