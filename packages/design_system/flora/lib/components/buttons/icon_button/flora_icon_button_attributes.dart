/// Flora DS — Icon Button Attributes
library;

import 'package:flutter/widgets.dart';

enum FloraIconButtonVariant { standard, filled, tonal, outlined }

class FloraIconButtonAttributes {
  const FloraIconButtonAttributes({
    required this.icon,
    required this.onPressed,
    required this.variant,
    this.isSelected = false,
    this.selectedIcon,
    this.tooltip,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final FloraIconButtonVariant variant;
  final bool isSelected;
  final Widget? selectedIcon;
  final String? tooltip;
}