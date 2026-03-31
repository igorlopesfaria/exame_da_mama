/// Flora DS — Semantic Color Theme Extension
/// Provides success, warning, info and error-extra color roles
/// following the same MD3 pattern (color / onColor / colorContainer / onColorContainer / subtle).
library;

import 'package:flutter/material.dart';
import 'package:flora/core/tokens/flora_colors.dart';

@immutable
class FloraSemanticColors extends ThemeExtension<FloraSemanticColors> {
  const FloraSemanticColors({
    // Success
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.successSubtle,
    // Warning
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.warningSubtle,
    // Info
    required this.info,
    required this.onInfo,
    required this.infoContainer,
    required this.onInfoContainer,
    required this.infoSubtle,
    // Error extras
    required this.errorSubtle,
  });

  // ── Success ───────────────────────────────────────────────────────────────
  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;
  final Color successSubtle;

  // ── Warning ───────────────────────────────────────────────────────────────
  final Color warning;
  final Color onWarning;
  final Color warningContainer;
  final Color onWarningContainer;
  final Color warningSubtle;

  // ── Info ──────────────────────────────────────────────────────────────────
  final Color info;
  final Color onInfo;
  final Color infoContainer;
  final Color onInfoContainer;
  final Color infoSubtle;

  // ── Error extras ──────────────────────────────────────────────────────────
  final Color errorSubtle;

  // ── Static instances ──────────────────────────────────────────────────────

  static const light = FloraSemanticColors(
    success:            FloraColors.success,
    onSuccess:          FloraColors.onSuccess,
    successContainer:   FloraColors.successContainer,
    onSuccessContainer: FloraColors.onSuccessContainer,
    successSubtle:      FloraColors.successSubtle,
    warning:            FloraColors.warning,
    onWarning:          FloraColors.onWarning,
    warningContainer:   FloraColors.warningContainer,
    onWarningContainer: FloraColors.onWarningContainer,
    warningSubtle:      FloraColors.warningSubtle,
    info:               FloraColors.info,
    onInfo:             FloraColors.onInfo,
    infoContainer:      FloraColors.infoContainer,
    onInfoContainer:    FloraColors.onInfoContainer,
    infoSubtle:         FloraColors.infoSubtle,
    errorSubtle:        FloraColors.errorSubtle,
  );

  static const dark = FloraSemanticColors(
    success:            FloraColors.successDark,
    onSuccess:          FloraColors.onSuccessDark,
    successContainer:   FloraColors.successContainerDark,
    onSuccessContainer: FloraColors.onSuccessContainerDark,
    successSubtle:      FloraColors.successSubtleDark,
    warning:            FloraColors.warningDark,
    onWarning:          FloraColors.onWarningDark,
    warningContainer:   FloraColors.warningContainerDark,
    onWarningContainer: FloraColors.onWarningContainerDark,
    warningSubtle:      FloraColors.warningSubtleDark,
    info:               FloraColors.infoDark,
    onInfo:             FloraColors.onInfoDark,
    infoContainer:      FloraColors.infoContainerDark,
    onInfoContainer:    FloraColors.onInfoContainerDark,
    infoSubtle:         FloraColors.infoSubtleDark,
    errorSubtle:        FloraColors.errorSubtleDark,
  );

  // ── ThemeExtension overrides ───────────────────────────────────────────────

  @override
  FloraSemanticColors copyWith({
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? successSubtle,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? warningSubtle,
    Color? info,
    Color? onInfo,
    Color? infoContainer,
    Color? onInfoContainer,
    Color? infoSubtle,
    Color? errorSubtle,
  }) =>
      FloraSemanticColors(
        success:            success            ?? this.success,
        onSuccess:          onSuccess          ?? this.onSuccess,
        successContainer:   successContainer   ?? this.successContainer,
        onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
        successSubtle:      successSubtle      ?? this.successSubtle,
        warning:            warning            ?? this.warning,
        onWarning:          onWarning          ?? this.onWarning,
        warningContainer:   warningContainer   ?? this.warningContainer,
        onWarningContainer: onWarningContainer ?? this.onWarningContainer,
        warningSubtle:      warningSubtle      ?? this.warningSubtle,
        info:               info               ?? this.info,
        onInfo:             onInfo             ?? this.onInfo,
        infoContainer:      infoContainer      ?? this.infoContainer,
        onInfoContainer:    onInfoContainer    ?? this.onInfoContainer,
        infoSubtle:         infoSubtle         ?? this.infoSubtle,
        errorSubtle:        errorSubtle        ?? this.errorSubtle,
      );

  @override
  FloraSemanticColors lerp(ThemeExtension<FloraSemanticColors>? other, double t) {
    if (other is! FloraSemanticColors) return this;
    return FloraSemanticColors(
      success:            Color.lerp(success,            other.success,            t)!,
      onSuccess:          Color.lerp(onSuccess,          other.onSuccess,          t)!,
      successContainer:   Color.lerp(successContainer,   other.successContainer,   t)!,
      onSuccessContainer: Color.lerp(onSuccessContainer, other.onSuccessContainer, t)!,
      successSubtle:      Color.lerp(successSubtle,      other.successSubtle,      t)!,
      warning:            Color.lerp(warning,            other.warning,            t)!,
      onWarning:          Color.lerp(onWarning,          other.onWarning,          t)!,
      warningContainer:   Color.lerp(warningContainer,   other.warningContainer,   t)!,
      onWarningContainer: Color.lerp(onWarningContainer, other.onWarningContainer, t)!,
      warningSubtle:      Color.lerp(warningSubtle,      other.warningSubtle,      t)!,
      info:               Color.lerp(info,               other.info,               t)!,
      onInfo:             Color.lerp(onInfo,             other.onInfo,             t)!,
      infoContainer:      Color.lerp(infoContainer,      other.infoContainer,      t)!,
      onInfoContainer:    Color.lerp(onInfoContainer,    other.onInfoContainer,    t)!,
      infoSubtle:         Color.lerp(infoSubtle,         other.infoSubtle,         t)!,
      errorSubtle:        Color.lerp(errorSubtle,        other.errorSubtle,        t)!,
    );
  }
}
