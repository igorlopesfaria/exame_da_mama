/// Flora DS — Switch Style
library;

import 'package:flutter/material.dart';

abstract final class FloraSwitchStyle {
  static const double hoverOpacity   = 0.08;
  static const double focusOpacity   = 0.10;
  static const double pressedOpacity = 0.10;

  static WidgetStateProperty<Color?> overlayColor(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) return cs.primary.withValues(alpha: pressedOpacity);
      if (states.contains(WidgetState.focused)) return cs.primary.withValues(alpha: focusOpacity);
      if (states.contains(WidgetState.hovered)) return cs.primary.withValues(alpha: hoverOpacity);
      return null;
    });
  }
}