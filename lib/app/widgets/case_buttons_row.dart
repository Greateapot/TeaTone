import 'package:flutter/material.dart';

import 'case_button.dart';

class CaseButtonsRow extends StatelessWidget {
  const CaseButtonsRow({
    super.key,
    required this.caseButtonsData,
    this.padding = const EdgeInsets.all(8.0),
  });

  final EdgeInsets padding;
  final List<CaseButtonData> caseButtonsData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (var caseButtonData in caseButtonsData)
            CaseButton(caseButtonData: caseButtonData)
        ],
      ),
    );
  }
}
