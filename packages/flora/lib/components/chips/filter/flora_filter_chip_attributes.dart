/// Flora DS — Filter Chip Attributes
library;

import 'package:flutter/widgets.dart';

class FloraFilterChipAttributes {
  const FloraFilterChipAttributes({
    required this.label,
    required this.selected,
    required this.onSelected,
    this.avatar,
    this.tooltip,
    this.elevated = false,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final Widget? avatar;
  final String? tooltip;
  final bool elevated;
}