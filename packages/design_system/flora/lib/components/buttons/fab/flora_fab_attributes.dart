/// Flora DS — FAB Attributes
library;

import 'package:flutter/widgets.dart';

enum FloraFABSize { small, regular, large }

class FloraFABAttributes {
  const FloraFABAttributes({
    required this.icon,
    required this.onPressed,
    required this.size,
    this.label,
    this.tooltip,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final FloraFABSize size;
  final String? label;
  final String? tooltip;
}