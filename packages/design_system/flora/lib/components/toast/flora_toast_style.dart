/// Flora DS — Toast Style Resolver
library;

import 'package:flutter/material.dart';
import 'package:flora/core/tokens/flora_radius.dart';
import 'package:flora/components/toast/flora_toast_attributes.dart';
import 'package:flora/core/theme/colors/flora_semantic_colors.dart';

class FloraToastStyleData {
  const FloraToastStyleData({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.actionColor,
    required this.iconData,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final Color actionColor;
  final IconData iconData;
}

abstract final class FloraToastStyle {
  static FloraToastStyleData resolve(
    BuildContext context,
    FloraToastVariant variant,
  ) {
    final cs       = Theme.of(context).colorScheme;
    final semantic = Theme.of(context).extension<FloraSemanticColors>()!;
    return switch (variant) {
      FloraToastVariant.info => FloraToastStyleData(
          backgroundColor: semantic.infoContainer,
          foregroundColor: semantic.onInfoContainer,
          actionColor:     semantic.info,
          iconData:        Icons.info_outline_rounded,
        ),
      FloraToastVariant.success => FloraToastStyleData(
          backgroundColor: semantic.successContainer,
          foregroundColor: semantic.onSuccessContainer,
          actionColor:     semantic.success,
          iconData:        Icons.check_circle_outline_rounded,
        ),
      FloraToastVariant.warning => FloraToastStyleData(
          backgroundColor: semantic.warningContainer,
          foregroundColor: semantic.onWarningContainer,
          actionColor:     semantic.warning,
          iconData:        Icons.warning_amber_rounded,
        ),
      FloraToastVariant.error => FloraToastStyleData(
          backgroundColor: cs.errorContainer,
          foregroundColor: cs.onErrorContainer,
          actionColor:     cs.error,
          iconData:        Icons.error_outline_rounded,
        ),
    };
  }

  static BorderRadius get shape          => FloraRadius.extraSmall;
  static const double horizontalMargin  = 16;
  static const double bottomMargin      = 16;
  static const double topMargin         = 16;
  static const double maxWidth          = 560;
  static const EdgeInsets contentPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 14);
  static const Duration enterDuration   = Duration(milliseconds: 300);
  static const Duration exitDuration    = Duration(milliseconds: 200);
  static const Curve enterCurve         = Curves.easeOutCubic;
  static const Curve exitCurve          = Curves.easeInCubic;
}
