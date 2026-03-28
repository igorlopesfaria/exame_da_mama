/// Flora DS — Card Attributes
library;

import 'package:flutter/widgets.dart';

enum FloraCardVariant { elevated, filled, outlined }

class FloraCardAttributes {
  const FloraCardAttributes({
    required this.child,
    this.variant = FloraCardVariant.elevated,
    this.onTap,
    this.onLongPress,
    this.padding,
    this.margin,
    this.semanticLabel,
  });

  final Widget child;
  final FloraCardVariant variant;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final String? semanticLabel;
}
