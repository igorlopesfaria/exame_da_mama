/// Flora DS — FAB Style
library;

import 'package:flutter/material.dart';
import 'package:flora/core/tokens/flora_radius.dart';
import 'package:flora/components/buttons/fab/flora_fab_attributes.dart';

abstract final class FloraFABStyle {
  static ShapeBorder shape(FloraFABSize size) => switch (size) {
    FloraFABSize.small   => const RoundedRectangleBorder(borderRadius: FloraRadius.large),
    FloraFABSize.regular => const RoundedRectangleBorder(borderRadius: FloraRadius.extraLarge),
    FloraFABSize.large   => const RoundedRectangleBorder(borderRadius: FloraRadius.extraLarge),
  };

  static double dimension(FloraFABSize size) => switch (size) {
    FloraFABSize.small   => 40,
    FloraFABSize.regular => 56,
    FloraFABSize.large   => 96,
  };
}
