/// Flora DS — FloraInputChip Component
library;

import 'package:flutter/material.dart';
import 'package:flora/components/chips/input/flora_input_chip_attributes.dart';
import 'package:flora/components/chips/input/flora_input_chip_style.dart';

class FloraInputChip extends StatelessWidget {
  FloraInputChip({
    super.key,
    required String label,
    Widget? avatar,
    VoidCallback? onPressed,
    VoidCallback? onDeleted,
    String? tooltip,
    bool selected = false,
  }) : _attributes = FloraInputChipAttributes(
         label: label,
         avatar: avatar,
         onPressed: onPressed,
         onDeleted: onDeleted,
         tooltip: tooltip,
         selected: selected,
       );

  final FloraInputChipAttributes _attributes;

  @override
  Widget build(BuildContext context) => Theme(
    data: Theme.of(context).copyWith(
      chipTheme: FloraInputChipStyle.resolveTheme(context),
    ),
    child: InputChip(
      label: Text(_attributes.label),
      avatar: _attributes.avatar,
      onPressed: _attributes.onPressed,
      onDeleted: _attributes.onDeleted,
      tooltip: _attributes.tooltip,
      selected: _attributes.selected,
    ),
  );
}
