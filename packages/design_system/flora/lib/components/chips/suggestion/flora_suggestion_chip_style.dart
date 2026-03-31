/// Flora DS — Suggestion Chip Style
library;

import 'package:flutter/material.dart';
import 'package:flora/core/tokens/flora_radius.dart';

abstract final class FloraSuggestionChipStyle {
  static ChipThemeData resolveTheme(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ChipThemeData(
      shape: const RoundedRectangleBorder(borderRadius: FloraRadius.small),
      side: BorderSide(color: cs.outline),
      labelStyle: Theme.of(context).textTheme.labelLarge,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    );
  }
}
