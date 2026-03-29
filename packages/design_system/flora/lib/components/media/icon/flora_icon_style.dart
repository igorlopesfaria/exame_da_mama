/// Flora DS Media — Icon Style
library;

import 'package:flutter/material.dart';
import 'flora_icon_attributes.dart';

abstract final class FloraIconStyle {
  static const double defaultSize = 24;

  static Color? resolveColor(BuildContext context, FloraIconColor color) {
    final cs = Theme.of(context).colorScheme;
    return switch (color) {
      FloraIconColor.primary   => cs.onSurface,
      FloraIconColor.accent    => cs.primary,
      FloraIconColor.secondary => cs.outline,
      FloraIconColor.error     => cs.error,
      FloraIconColor.success   => cs.tertiary,
      FloraIconColor.disabled  => cs.onSurface.withValues(alpha: 0.38),
      FloraIconColor.onPrimary => cs.onPrimary,
      FloraIconColor.inherit   => null,
    };
  }

  static double resolveSize(double? size) => size ?? defaultSize;
}
