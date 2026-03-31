import 'package:flutter/material.dart';

/// Flora DS — MD3 Color Roles
/// Seed color: #C9317E
abstract final class FloraColors {
  // Primary
  static const primary            = Color(0xFFC9317E);
  static const onPrimary          = Color(0xFFFFFFFF);
  static const primaryContainer   = Color(0xFFFFD9E8);
  static const onPrimaryContainer = Color(0xFF3E0021);

  // Secondary
  static const secondary            = Color(0xFF74565F);
  static const onSecondary          = Color(0xFFFFFFFF);
  static const secondaryContainer   = Color(0xFFFFD9E3);
  static const onSecondaryContainer = Color(0xFF2B1519);

  // Tertiary
  static const tertiary            = Color(0xFF7B5635);
  static const onTertiary          = Color(0xFFFFFFFF);
  static const tertiaryContainer   = Color(0xFFFFD9BC);
  static const onTertiaryContainer = Color(0xFF2E1500);

  // Error
  static const error            = Color(0xFFBA1A1A);
  static const onError          = Color(0xFFFFFFFF);
  static const errorContainer   = Color(0xFFFFDAD6);
  static const onErrorContainer = Color(0xFF410002);

  // Surface
  static const surface                   = Color(0xFFFFF8F8);
  static const onSurface                 = Color(0xFF201A1B);
  static const onSurfaceVariant          = Color(0xFF514347);
  static const surfaceContainerLowest    = Color(0xFFFFFFFF);
  static const surfaceContainerLow       = Color(0xFFFFF0F2);
  static const surfaceContainer          = Color(0xFFFCEAED);
  static const surfaceContainerHigh      = Color(0xFFF6E4E7);
  static const surfaceContainerHighest   = Color(0xFFF0DEE1);

  // Outline
  static const outline        = Color(0xFF837377);
  static const outlineVariant = Color(0xFFD4BBBE);

  // Inverse
  static const inverseSurface   = Color(0xFF352F30);
  static const inverseOnSurface = Color(0xFFFAEEEF);
  static const inversePrimary   = Color(0xFFFFB0CB);

  static const scrim = Color(0xFF000000);

  // ── Semantic: Success (green) ──────────────────────────────────────────────
  static const success            = Color(0xFF1B6E38);
  static const onSuccess          = Color(0xFFFFFFFF);
  static const successContainer   = Color(0xFFA8F5B2);
  static const onSuccessContainer = Color(0xFF00210D);
  static const successSubtle      = Color(0xFFE6F9EB);

  // ── Semantic: Warning (amber) ─────────────────────────────────────────────
  static const warning            = Color(0xFF7A5500);
  static const onWarning          = Color(0xFFFFFFFF);
  static const warningContainer   = Color(0xFFFFDFA3);
  static const onWarningContainer = Color(0xFF261900);
  static const warningSubtle      = Color(0xFFFFF8E1);

  // ── Semantic: Info (blue) ─────────────────────────────────────────────────
  static const info            = Color(0xFF0061A4);
  static const onInfo          = Color(0xFFFFFFFF);
  static const infoContainer   = Color(0xFFD1E4FF);
  static const onInfoContainer = Color(0xFF001D36);
  static const infoSubtle      = Color(0xFFE8F1FF);

  // ── Semantic: Error extras (alinhado ao MD3 error já existente) ───────────
  static const errorSubtle = Color(0xFFFFF0EE);

  // --- DARK ---
  static const primaryDark            = Color(0xFFFFB0CB);
  static const onPrimaryDark          = Color(0xFF5E1140);
  static const primaryContainerDark   = Color(0xFF7D1758);
  static const onPrimaryContainerDark = Color(0xFFFFD9E8);

  static const secondaryDark            = Color(0xFFE2BDCA);
  static const onSecondaryDark          = Color(0xFF41272D);
  static const secondaryContainerDark   = Color(0xFF5A3D44);
  static const onSecondaryContainerDark = Color(0xFFFFD9E3);

  static const tertiaryDark            = Color(0xFFEFBC92);
  static const onTertiaryDark          = Color(0xFF45260A);
  static const tertiaryContainerDark   = Color(0xFF5E3C1F);
  static const onTertiaryContainerDark = Color(0xFFFFD9BC);

  static const errorDark            = Color(0xFFFFB4AB);
  static const onErrorDark          = Color(0xFF690005);
  static const errorContainerDark   = Color(0xFF93000A);
  static const onErrorContainerDark = Color(0xFFFFDAD6);

  static const surfaceDark                 = Color(0xFF181213);
  static const onSurfaceDark               = Color(0xFFF0DEE1);
  static const onSurfaceVariantDark        = Color(0xFFD4BBBE);
  static const surfaceContainerLowestDark  = Color(0xFF120D0E);
  static const surfaceContainerLowDark     = Color(0xFF201A1B);
  static const surfaceContainerDark        = Color(0xFF241E1F);
  static const surfaceContainerHighDark    = Color(0xFF2F2829);
  static const surfaceContainerHighestDark = Color(0xFF3A3334);

  static const outlineDark        = Color(0xFF9E8589);
  static const outlineVariantDark = Color(0xFF514347);

  static const inverseSurfaceDark   = Color(0xFFF0DEE1);
  static const inverseOnSurfaceDark = Color(0xFF352F30);
  static const inversePrimaryDark   = Color(0xFFC9317E);

  // ── Semantic dark: Success ────────────────────────────────────────────────
  static const successDark            = Color(0xFF8CD898);
  static const onSuccessDark          = Color(0xFF00391A);
  static const successContainerDark   = Color(0xFF005228);
  static const onSuccessContainerDark = Color(0xFFA8F5B2);
  static const successSubtleDark      = Color(0xFF002112);

  // ── Semantic dark: Warning ────────────────────────────────────────────────
  static const warningDark            = Color(0xFFEFC048);
  static const onWarningDark          = Color(0xFF3F2D00);
  static const warningContainerDark   = Color(0xFF5A3F00);
  static const onWarningContainerDark = Color(0xFFFFDFA3);
  static const warningSubtleDark      = Color(0xFF2B2000);

  // ── Semantic dark: Info ───────────────────────────────────────────────────
  static const infoDark            = Color(0xFF9ECAFF);
  static const onInfoDark          = Color(0xFF003258);
  static const infoContainerDark   = Color(0xFF00497D);
  static const onInfoContainerDark = Color(0xFFD1E4FF);
  static const infoSubtleDark      = Color(0xFF001C36);

  // ── Semantic dark: Error extras ───────────────────────────────────────────
  static const errorSubtleDark = Color(0xFF2D0001);
}
