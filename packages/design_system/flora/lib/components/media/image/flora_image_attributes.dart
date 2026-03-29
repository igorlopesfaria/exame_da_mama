/// Flora DS Media — Image Attributes
library;

import 'package:flutter/widgets.dart';

enum FloraImageVariant { asset, network }

enum FloraImageFit {
  contain,
  cover,
  fill,
  fitHeight,
  fitWidth,
  none,
  scaleDown,
}

class FloraImageAttributes {
  const FloraImageAttributes({
    required this.source,
    required this.variant,
    this.width,
    this.height,
    this.fit = FloraImageFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.semanticLabel,
  });

  final String source;
  final FloraImageVariant variant;
  final double? width;
  final double? height;
  final FloraImageFit fit;
  final BorderRadiusGeometry? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final String? semanticLabel;
}
