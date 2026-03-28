/// Flora DS — Suggestion Chip Attributes
library;

import 'package:flutter/widgets.dart';

class FloraSuggestionChipAttributes {
  const FloraSuggestionChipAttributes({
    required this.label,
    this.onPressed,
    this.tooltip,
    this.elevated = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final String? tooltip;
  final bool elevated;
}