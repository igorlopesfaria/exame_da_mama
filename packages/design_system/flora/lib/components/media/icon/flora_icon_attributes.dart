/// Flora DS Media — Icon Attributes
library;

import 'package:flutter/widgets.dart';

enum FloraIconVariant { flutter, asset }

enum FloraIconColor {
  /// [onSurface] — default content
  primary,
  /// [colorScheme.primary] — brand accent
  accent,
  /// [outline] — secondary / muted
  secondary,
  /// [error]
  error,
  /// [tertiary] — success
  success,
  /// [onSurface 38%] — disabled state
  disabled,
  /// [onPrimary] — use on filled/primary surfaces
  onPrimary,
  /// No theme override — inherits parent
  inherit,
}

class FloraIconAttributes {
  const FloraIconAttributes({
    required this.variant,
    this.iconData,
    this.assetPath,
    this.size,
    this.color = FloraIconColor.primary,
    this.semanticLabel,
  });

  final FloraIconVariant variant;
  final IconData? iconData;
  final String? assetPath;
  final double? size;
  final FloraIconColor color;
  final String? semanticLabel;
}
