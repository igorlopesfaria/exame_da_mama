/// Flora DS Media — Animation Attributes
library;

import 'package:flutter/widgets.dart';

enum FloraAnimationFit {
  contain,
  cover,
  fill,
  fitHeight,
  fitWidth,
  none,
  scaleDown,
}

class FloraAnimationAttributes {
  const FloraAnimationAttributes({
    required this.assetPath,
    this.width,
    this.height,
    this.fit = FloraAnimationFit.contain,
    this.repeat = true,
    this.reverse = false,
    this.animate = true,
    this.onLoaded,
    this.semanticLabel,
  });

  final String assetPath;
  final double? width;
  final double? height;
  final FloraAnimationFit fit;
  final bool repeat;
  final bool reverse;
  final bool animate;
  final VoidCallback? onLoaded;
  final String? semanticLabel;
}
