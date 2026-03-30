import 'package:flutter/material.dart';
import 'package:flora/core/tokens/flora_typography.dart';
import 'package:flora/core/theme/colors/flora_color_scheme.dart';
import 'package:flora/core/theme/colors/flora_semantic_colors.dart';

abstract final class FloraThemeBase {
  static ThemeData get light => _build(
        colorScheme: FloraColorScheme.light,
        semanticColors: FloraSemanticColors.light,
      );

  static ThemeData get dark => _build(
        colorScheme: FloraColorScheme.dark,
        semanticColors: FloraSemanticColors.dark,
      );

  static ThemeData _build({
    required ColorScheme colorScheme,
    required FloraSemanticColors semanticColors,
  }) =>
      ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        textTheme: FloraTypography.textTheme,
        extensions: [semanticColors],
      );
}