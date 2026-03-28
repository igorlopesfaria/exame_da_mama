/// Flora DS — Text Attributes
library;

import 'package:flutter/material.dart';

enum FloraTextStyle {
  displayLarge, displayMedium, displaySmall,
  headlineLarge, headlineMedium, headlineSmall,
  titleLarge, titleMedium, titleSmall,
  labelLarge, labelMedium, labelSmall,
  bodyLarge, bodyMedium, bodySmall,
}

enum FloraTextColor {
  /// [onSurface] — primary content
  primary,
  /// [outline] — secondary content, hints
  secondary,
  /// [colorScheme.primary] — brand accent, links
  accent,
  /// [error]
  error,
  /// [tertiary] — success messages
  success,
  /// [inverseOnSurface]
  inverse,
  /// [onSurface 38%]
  disabled,
  /// No override — inherits parent
  inherit,
}

enum FloraTextAlign { left, center, right, justify, start, end }

enum FloraTextOverflow { clip, fade, ellipsis, visible }

class FloraTextAttributes {
  const FloraTextAttributes({
    required this.text,
    this.style = FloraTextStyle.bodyMedium,
    this.color = FloraTextColor.primary,
    this.align,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.overrideStyle,
    this.semanticsLabel,
  });

  final String text;
  final FloraTextStyle style;
  final FloraTextColor color;
  final FloraTextAlign? align;
  final FloraTextOverflow? overflow;
  final int? maxLines;
  final bool? softWrap;
  final TextStyle? overrideStyle;
  final String? semanticsLabel;
}