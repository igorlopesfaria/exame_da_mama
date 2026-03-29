/// Flora DS — Input Chip Attributes
library;

import 'package:flutter/widgets.dart';

class FloraInputChipAttributes {
  const FloraInputChipAttributes({
    required this.label,
    this.avatar,
    this.onPressed,
    this.onDeleted,
    this.tooltip,
    this.selected = false,
  });

  final String label;
  final Widget? avatar;
  final VoidCallback? onPressed;
  final VoidCallback? onDeleted;
  final String? tooltip;
  final bool selected;
}
