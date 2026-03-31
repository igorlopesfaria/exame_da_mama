/// Flora DS — Bottom Sheet Style
library;

import 'package:flutter/material.dart';
import 'package:flora/core/tokens/flora_radius.dart';
import 'package:flora/core/tokens/flora_spacing.dart';

abstract final class FloraBottomSheetStyle {
  static const BorderRadius topRadius = BorderRadius.only(
    topLeft: Radius.circular(FloraRadius.extraLargeValue),
    topRight: Radius.circular(FloraRadius.extraLargeValue),
  );

  static const double handleWidth = 32;
  static const double handleHeight = 4;
  static const double handleVerticalPadding = FloraSpacing.s3;

  static const EdgeInsets contentPadding = EdgeInsets.fromLTRB(
    FloraSpacing.s4,
    FloraSpacing.s2,
    FloraSpacing.s4,
    FloraSpacing.s4,
  );

  static Color backgroundColor(BuildContext context) =>
      Theme.of(context).colorScheme.surface;

  static Color handleColor(BuildContext context) =>
      Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.4);
}
