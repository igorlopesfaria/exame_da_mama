/// Flora DS — Button Style
library;

import 'package:flutter/material.dart';
import 'flora_button_attributes.dart';

abstract final class FloraButtonStyle {
  static ButtonStyle resolve(BuildContext context, FloraButtonVariant variant, FloraButtonSize size) {
    final height  = _heightFor(size);
    final padding = _paddingFor(size);
    return switch (variant) {
      FloraButtonVariant.filled   => _filled(context, height, padding),
      FloraButtonVariant.tonal    => _tonal(context, height, padding),
      FloraButtonVariant.outlined => _outlined(context, height, padding),
      FloraButtonVariant.text     => _text(context, height, padding),
      FloraButtonVariant.elevated => _elevated(context, height, padding),
    };
  }

  static double _heightFor(FloraButtonSize size) => switch (size) {
    FloraButtonSize.small  => 32,
    FloraButtonSize.medium => 40,
    FloraButtonSize.large  => 48,
  };

  static EdgeInsets _paddingFor(FloraButtonSize size) => switch (size) {
    FloraButtonSize.small  => const EdgeInsets.symmetric(horizontal: 16),
    FloraButtonSize.medium => const EdgeInsets.symmetric(horizontal: 24),
    FloraButtonSize.large  => const EdgeInsets.symmetric(horizontal: 32),
  };

  static ButtonStyle _filled(BuildContext context, double height, EdgeInsets padding) {
    final cs = Theme.of(context).colorScheme;
    return FilledButton.styleFrom(
      minimumSize: Size(64, height), padding: padding, shape: const StadiumBorder(),
      backgroundColor: cs.primary, foregroundColor: cs.onPrimary,
      disabledBackgroundColor: cs.onSurface.withValues(alpha: 0.12),
      disabledForegroundColor: cs.onSurface.withValues(alpha: 0.38),
    );
  }

  static ButtonStyle _tonal(BuildContext context, double height, EdgeInsets padding) {
    final cs = Theme.of(context).colorScheme;
    return FilledButton.styleFrom(
      minimumSize: Size(64, height), padding: padding, shape: const StadiumBorder(),
      backgroundColor: cs.secondaryContainer, foregroundColor: cs.onSecondaryContainer,
      disabledBackgroundColor: cs.onSurface.withValues(alpha: 0.12),
      disabledForegroundColor: cs.onSurface.withValues(alpha: 0.38),
    );
  }

  static ButtonStyle _outlined(BuildContext context, double height, EdgeInsets padding) {
    final cs = Theme.of(context).colorScheme;
    return OutlinedButton.styleFrom(
      minimumSize: Size(64, height), padding: padding, shape: const StadiumBorder(),
      foregroundColor: cs.primary, side: BorderSide(color: cs.primary),
      disabledForegroundColor: cs.onSurface.withValues(alpha: 0.38),
    );
  }

  static ButtonStyle _text(BuildContext context, double height, EdgeInsets padding) {
    final cs = Theme.of(context).colorScheme;
    return TextButton.styleFrom(
      minimumSize: Size(64, height), padding: padding.copyWith(left: 12, right: 12),
      shape: const StadiumBorder(), foregroundColor: cs.primary,
      disabledForegroundColor: cs.onSurface.withValues(alpha: 0.38),
      textStyle: const TextStyle(decoration: TextDecoration.underline),
    );
  }

  static ButtonStyle _elevated(BuildContext context, double height, EdgeInsets padding) {
    final cs = Theme.of(context).colorScheme;
    return ElevatedButton.styleFrom(
      minimumSize: Size(64, height), padding: padding, shape: const StadiumBorder(),
      foregroundColor: cs.primary, backgroundColor: cs.surfaceContainerLow,
      disabledForegroundColor: cs.onSurface.withValues(alpha: 0.38),
      disabledBackgroundColor: cs.onSurface.withValues(alpha: 0.12), elevation: 1,
    );
  }

  static Color loadingColor(BuildContext context, FloraButtonVariant variant) {
    final cs = Theme.of(context).colorScheme;
    return switch (variant) {
      FloraButtonVariant.filled   => cs.onPrimary,
      FloraButtonVariant.tonal    => cs.onSecondaryContainer,
      FloraButtonVariant.elevated => cs.primary,
      _                           => cs.primary,
    };
  }
}
