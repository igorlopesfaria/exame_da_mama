/// Flora DS — Feedback State Style
library;

import 'package:flutter/material.dart';
import 'package:flora/components/feedback/flora_feedback_attributes.dart';
import 'package:flora/core/theme/colors/flora_semantic_colors.dart';

class FloraFeedbackStateStyle {
  const FloraFeedbackStateStyle({required this.icon, required this.iconColor, required this.containerColor});
  final IconData icon;
  final Color iconColor;
  final Color containerColor;

  static FloraFeedbackStateStyle resolve(BuildContext context, FloraFeedbackType type) {
    final cs       = Theme.of(context).colorScheme;
    final semantic = Theme.of(context).extension<FloraSemanticColors>()!;
    return switch (type) {
      FloraFeedbackType.empty           => FloraFeedbackStateStyle(icon: Icons.medical_information_outlined, iconColor: cs.primary,          containerColor: cs.primaryContainer),
      FloraFeedbackType.connectionError => FloraFeedbackStateStyle(icon: Icons.wifi_off_outlined,           iconColor: cs.error,             containerColor: cs.errorContainer),
      FloraFeedbackType.genericError    => FloraFeedbackStateStyle(icon: Icons.warning_amber_outlined,      iconColor: semantic.warning,     containerColor: semantic.warningContainer),
    };
  }
}
