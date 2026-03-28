/// Flora DS — Assist Chip Attributes
library;

import 'package:flutter/widgets.dart';

class FloraAssistChipAttributes {
  const FloraAssistChipAttributes({
    required this.label,
    this.avatar,
    this.onPressed,
    this.tooltip,
    this.elevated = false,
  });

  final String label;
  final Widget? avatar;
  final VoidCallback? onPressed;
  final String? tooltip;
  final bool elevated;
}
