/// Flora DS — Text Input Code Style
library;

import 'package:flutter/material.dart';
import 'package:flora/core/tokens/flora_radius.dart';
import 'package:flora/core/tokens/flora_spacing.dart';
import 'flora_text_input_code_attributes.dart';

class FloraTextInputCodeStyleData {
  const FloraTextInputCodeStyleData({
    required this.boxDecoration,
    required this.focusedBoxDecoration,
    required this.errorBoxDecoration,
    required this.textStyle,
    required this.errorTextStyle,
  });

  final BoxDecoration boxDecoration;
  final BoxDecoration focusedBoxDecoration;
  final BoxDecoration errorBoxDecoration;
  final TextStyle textStyle;
  final TextStyle errorTextStyle;
}

abstract final class FloraTextInputCodeStyle {
  static const double boxSize = FloraSpacing.s12;
  static const double spacing = FloraSpacing.s2;

  static FloraTextInputCodeStyleData resolve(
    BuildContext context,
    FloraTextInputCodeVariant variant,
  ) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    const radius = FloraRadius.extraSmall;

    final BoxDecoration box;
    final BoxDecoration focused;
    final BoxDecoration error;

    switch (variant) {
      case FloraTextInputCodeVariant.outlined:
        box = BoxDecoration(
          borderRadius: radius,
          border: Border.all(color: cs.outline),
        );
        focused = BoxDecoration(
          borderRadius: radius,
          border: Border.all(color: cs.primary, width: 2),
        );
        error = BoxDecoration(
          borderRadius: radius,
          border: Border.all(color: cs.error, width: 2),
        );
      case FloraTextInputCodeVariant.filled:
        box = BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: radius,
          border: Border(bottom: BorderSide(color: cs.onSurfaceVariant)),
        );
        focused = BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: radius,
          border: Border(bottom: BorderSide(color: cs.primary, width: 2)),
        );
        error = BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: radius,
          border: Border(bottom: BorderSide(color: cs.error, width: 2)),
        );
    }

    return FloraTextInputCodeStyleData(
      boxDecoration: box,
      focusedBoxDecoration: focused,
      errorBoxDecoration: error,
      textStyle: tt.titleLarge!.copyWith(color: cs.onSurface),
      errorTextStyle: tt.bodySmall!.copyWith(color: cs.error),
    );
  }
}
