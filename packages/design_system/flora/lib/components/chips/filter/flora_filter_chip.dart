/// Flora DS — FloraFilterChip Component
library;

import 'package:flutter/material.dart';
import 'package:flora/components/chips/filter/flora_filter_chip_attributes.dart';
import 'flora_filter_chip_style.dart';

class FloraFilterChip extends StatelessWidget {
  FloraFilterChip({
    super.key,
    required String label,
    required bool selected,
    required ValueChanged<bool> onSelected,
    Widget? avatar,
    String? tooltip,
    bool elevated = false,
  }) : _attributes = FloraFilterChipAttributes(
         label: label,
         selected: selected,
         onSelected: onSelected,
         avatar: avatar,
         tooltip: tooltip,
         elevated: elevated,
       );

  final FloraFilterChipAttributes _attributes;

  @override
  Widget build(BuildContext context) => Theme(
    data: Theme.of(context).copyWith(
      chipTheme: FloraFilterChipStyle.resolveTheme(context),
    ),
    child: FilterChip(
      label: Text(_attributes.label),
      selected: _attributes.selected,
      onSelected: _attributes.onSelected,
      avatar: _attributes.avatar,
      tooltip: _attributes.tooltip,
      elevation: _attributes.elevated ? 2 : 0,
    ),
  );
}
