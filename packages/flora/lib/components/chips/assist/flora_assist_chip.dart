/// Flora DS — FloraAssistChip Component
library;

import 'package:flutter/material.dart';
import 'package:flora/components/chips/assist/flora_assist_chip_attributes.dart';
import 'package:flora/components/chips/assist/flora_assist_chip_style.dart';

class FloraAssistChip extends StatelessWidget {
  FloraAssistChip({
    super.key,
    required String label,
    Widget? avatar,
    VoidCallback? onPressed,
    String? tooltip,
    bool elevated = false,
  }) : _attributes = FloraAssistChipAttributes(
         label: label,
         avatar: avatar,
         onPressed: onPressed,
         tooltip: tooltip,
         elevated: elevated,
       );

  final FloraAssistChipAttributes _attributes;

  @override
  Widget build(BuildContext context) => Theme(
    data: Theme.of(context).copyWith(
      chipTheme: FloraAssistChipStyle.resolveTheme(context),
    ),
    child: ActionChip(
      label: Text(_attributes.label),
      avatar: _attributes.avatar,
      onPressed: _attributes.onPressed,
      tooltip: _attributes.tooltip,
      elevation: _attributes.elevated ? 2 : 0,
    ),
  );
}
