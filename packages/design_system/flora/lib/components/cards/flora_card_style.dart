/// Flora DS — Card Style
library;

import 'package:flutter/material.dart';
import 'package:flora/core/tokens/flora_radius.dart';
import 'flora_card_attributes.dart';

abstract final class FloraCardStyle {
  static CardThemeData resolveTheme(BuildContext context, FloraCardVariant variant) {
    final cs = Theme.of(context).colorScheme;
    return switch (variant) {
      FloraCardVariant.elevated => CardThemeData(elevation: 1, color: cs.surfaceContainerLow, surfaceTintColor: cs.surfaceTint, shape: const RoundedRectangleBorder(borderRadius: FloraRadius.medium), clipBehavior: Clip.antiAlias),
      FloraCardVariant.filled   => CardThemeData(elevation: 0, color: cs.surfaceContainerHighest, shape: const RoundedRectangleBorder(borderRadius: FloraRadius.medium), clipBehavior: Clip.antiAlias),
      FloraCardVariant.outlined => CardThemeData(elevation: 0, color: cs.surface, shape: RoundedRectangleBorder(borderRadius: FloraRadius.medium, side: BorderSide(color: cs.outlineVariant)), clipBehavior: Clip.antiAlias),
    };
  }
}
