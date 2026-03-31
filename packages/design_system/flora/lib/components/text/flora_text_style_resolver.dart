/// Flora DS — Text Style Resolver
library;

import 'package:flutter/material.dart';
import 'package:flora/components/text/flora_text_attributes.dart';

abstract final class FloraTextStyleResolver {
  static TextStyle? resolveTextStyle(BuildContext context, FloraTextStyle style) {
    final tt = Theme.of(context).textTheme;
    return switch (style) {
      FloraTextStyle.displayLarge   => tt.displayLarge,
      FloraTextStyle.displayMedium  => tt.displayMedium,
      FloraTextStyle.displaySmall   => tt.displaySmall,
      FloraTextStyle.headlineLarge  => tt.headlineLarge,
      FloraTextStyle.headlineMedium => tt.headlineMedium,
      FloraTextStyle.headlineSmall  => tt.headlineSmall,
      FloraTextStyle.titleLarge     => tt.titleLarge,
      FloraTextStyle.titleMedium    => tt.titleMedium,
      FloraTextStyle.titleSmall     => tt.titleSmall,
      FloraTextStyle.labelLarge     => tt.labelLarge,
      FloraTextStyle.labelMedium    => tt.labelMedium,
      FloraTextStyle.labelSmall     => tt.labelSmall,
      FloraTextStyle.bodyLarge      => tt.bodyLarge,
      FloraTextStyle.bodyMedium     => tt.bodyMedium,
      FloraTextStyle.bodySmall      => tt.bodySmall,
    };
  }

  static Color? resolveColor(BuildContext context, FloraTextColor color) {
    final cs = Theme.of(context).colorScheme;
    return switch (color) {
      FloraTextColor.primary   => cs.onSurface,
      FloraTextColor.secondary => cs.outline,
      FloraTextColor.accent    => cs.primary,
      FloraTextColor.error     => cs.error,
      FloraTextColor.success   => cs.tertiary,
      FloraTextColor.inverse   => cs.onInverseSurface,
      FloraTextColor.disabled  => cs.onSurface.withValues(alpha: 0.38),
      FloraTextColor.inherit   => null,
    };
  }

  static TextStyle? merge(BuildContext context, {required FloraTextStyle style, required FloraTextColor color, TextStyle? overrideStyle}) {
    final base = resolveTextStyle(context, style);
    final resolved = resolveColor(context, color);
    return base?.copyWith(color: resolved).merge(overrideStyle);
  }

  static TextAlign? resolveAlign(FloraTextAlign? align) => switch (align) {
    null                    => null,
    FloraTextAlign.left     => TextAlign.left,
    FloraTextAlign.center   => TextAlign.center,
    FloraTextAlign.right    => TextAlign.right,
    FloraTextAlign.justify  => TextAlign.justify,
    FloraTextAlign.start    => TextAlign.start,
    FloraTextAlign.end      => TextAlign.end,
  };

  static TextOverflow? resolveOverflow(FloraTextOverflow? overflow) => switch (overflow) {
    null                        => null,
    FloraTextOverflow.clip      => TextOverflow.clip,
    FloraTextOverflow.fade      => TextOverflow.fade,
    FloraTextOverflow.ellipsis  => TextOverflow.ellipsis,
    FloraTextOverflow.visible   => TextOverflow.visible,
  };
}
