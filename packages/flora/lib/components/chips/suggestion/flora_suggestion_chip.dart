/// Flora DS — Suggestion Chip Component
library;

import 'package:flutter/material.dart';
import 'package:flora/components/chips/suggestion/flora_suggestion_chip_attributes.dart';
import 'package:flora/components/chips/suggestion/flora_suggestion_chip_style.dart';

class FloraSuggestionChip extends StatelessWidget {
  FloraSuggestionChip({
    super.key,
    required String label,
    VoidCallback? onPressed,
    String? tooltip,
    bool elevated = false,
  }) : _attributes = FloraSuggestionChipAttributes(
          label: label,
          onPressed: onPressed,
          tooltip: tooltip,
          elevated: elevated,
        );

  final FloraSuggestionChipAttributes _attributes;

  @override
  Widget build(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(
          chipTheme: FloraSuggestionChipStyle.resolveTheme(context),
        ),
        child: ActionChip(
          label: Text(_attributes.label),
          onPressed: _attributes.onPressed,
          tooltip: _attributes.tooltip,
          elevation: _attributes.elevated ? 2 : 0,
        ),
      );
}