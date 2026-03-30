/// Flora DS Media — Animation Style
library;

import 'package:flutter/widgets.dart';
import 'flora_animation_attributes.dart';

abstract final class FloraAnimationStyle {
  static BoxFit resolveFit(FloraAnimationFit fit) => switch (fit) {
    FloraAnimationFit.contain   => BoxFit.contain,
    FloraAnimationFit.cover     => BoxFit.cover,
    FloraAnimationFit.fill      => BoxFit.fill,
    FloraAnimationFit.fitHeight => BoxFit.fitHeight,
    FloraAnimationFit.fitWidth  => BoxFit.fitWidth,
    FloraAnimationFit.none      => BoxFit.none,
    FloraAnimationFit.scaleDown => BoxFit.scaleDown,
  };
}
