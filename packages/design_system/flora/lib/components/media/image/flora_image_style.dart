/// Flora DS Media — Image Style
library;

import 'package:flutter/material.dart';
import 'flora_image_attributes.dart';

abstract final class FloraImageStyle {
  static BoxFit resolveFit(FloraImageFit fit) => switch (fit) {
    FloraImageFit.contain   => BoxFit.contain,
    FloraImageFit.cover     => BoxFit.cover,
    FloraImageFit.fill      => BoxFit.fill,
    FloraImageFit.fitHeight => BoxFit.fitHeight,
    FloraImageFit.fitWidth  => BoxFit.fitWidth,
    FloraImageFit.none      => BoxFit.none,
    FloraImageFit.scaleDown => BoxFit.scaleDown,
  };

  static Widget defaultPlaceholder(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      color: cs.surfaceContainerHighest,
      child: Center(
        child: CircularProgressIndicator(strokeWidth: 2, color: cs.primary),
      ),
    );
  }

  static Widget defaultErrorWidget(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      color: cs.errorContainer,
      child: Center(
        child: Icon(Icons.broken_image_outlined, color: cs.onErrorContainer),
      ),
    );
  }
}
