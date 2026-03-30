/// Flora DS — Progress Step Style
library;

import 'package:flutter/material.dart';
import 'package:flora/components/progress/step/flora_progress_step_attributes.dart';
import 'package:flora/core/theme/colors/flora_semantic_colors.dart';

abstract final class FloraProgressStepStyle {
  static const double defaultHeight = 4.0;
  static const double defaultSpacing = 4.0;

  static Color activeColor(BuildContext context, FloraProgressStepVariant variant) {
    final cs       = Theme.of(context).colorScheme;
    final semantic = Theme.of(context).extension<FloraSemanticColors>()!;
    return switch (variant) {
      FloraProgressStepVariant.primary   => cs.primary,
      FloraProgressStepVariant.secondary => cs.secondary,
      FloraProgressStepVariant.success   => semantic.success,
      FloraProgressStepVariant.error     => cs.error,
    };
  }

  static Color trackColor(BuildContext context) =>
      Theme.of(context).colorScheme.secondaryContainer;
}
