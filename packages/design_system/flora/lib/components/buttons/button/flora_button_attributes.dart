/// Flora DS — Button Attributes
library;

import 'package:flutter/widgets.dart';

enum FloraButtonVariant { filled, tonal, outlined, text, elevated }

enum FloraButtonSize {
  /// height: 32dp
  small,
  /// height: 40dp — default MD3
  medium,
  /// height: 48dp
  large,
}

class FloraButtonAttributes {
  const FloraButtonAttributes({
    required this.label,
    required this.onPressed,
    required this.variant,
    required this.size,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.tooltip,
  });

  final String label;
  final VoidCallback? onPressed;
  final FloraButtonVariant variant;
  final FloraButtonSize size;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool isLoading;
  final String? tooltip;

  bool get isEnabled => onPressed != null && !isLoading;
}