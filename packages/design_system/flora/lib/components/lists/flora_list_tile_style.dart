/// Flora DS — List Tile Style
library;

import 'package:flutter/material.dart';

abstract final class FloraListTileStyle {
  static ListTileThemeData resolveTheme(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListTileThemeData(
      tileColor: Colors.transparent,
      selectedTileColor: cs.secondaryContainer.withValues(alpha: 0.12),
      selectedColor: cs.onSecondaryContainer,
      iconColor: cs.onSurfaceVariant,
      textColor: cs.onSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      minVerticalPadding: 12,
    );
  }
}
