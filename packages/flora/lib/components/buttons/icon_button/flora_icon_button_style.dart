/// Flora DS — Icon Button Style
library;

import 'package:flutter/material.dart';

abstract final class FloraIconButtonStyle {
  static const double size     = 40;
  static const double iconSize = 24;

  static WidgetStateProperty<Color?> overlayColor(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) return cs.primary.withValues(alpha: 0.10);
      if (states.contains(WidgetState.focused)) return cs.primary.withValues(alpha: 0.10);
      if (states.contains(WidgetState.hovered)) return cs.primary.withValues(alpha: 0.08);
      return null;
    });
  }
}
