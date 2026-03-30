/// Flora DS — Feedback State Attributes
library;

import 'package:flutter/widgets.dart';

import 'package:flora/core/strings/localizations/flora_localizations.dart';

enum FloraFeedbackType { empty, connectionError, genericError }

abstract final class FloraFeedbackContent {
  static String title(BuildContext context, FloraFeedbackType type) {
    final l10n = FloraLocalizations.of(context)!;
    return switch (type) {
      FloraFeedbackType.empty => l10n.feedbackEmptyTitle,
      FloraFeedbackType.connectionError => l10n.feedbackConnectionErrorTitle,
      FloraFeedbackType.genericError => l10n.feedbackGenericErrorTitle,
    };
  }

  static String description(BuildContext context, FloraFeedbackType type) {
    final l10n = FloraLocalizations.of(context)!;
    return switch (type) {
      FloraFeedbackType.empty => l10n.feedbackEmptyDescription,
      FloraFeedbackType.connectionError => l10n.feedbackConnectionErrorDescription,
      FloraFeedbackType.genericError => l10n.feedbackGenericErrorDescription,
    };
  }

  static String primaryLabel(BuildContext context, FloraFeedbackType type) {
    final l10n = FloraLocalizations.of(context)!;
    return switch (type) {
      FloraFeedbackType.empty => l10n.feedbackEmptyPrimaryLabel,
      FloraFeedbackType.connectionError => l10n.feedbackConnectionErrorPrimaryLabel,
      FloraFeedbackType.genericError => l10n.feedbackGenericErrorPrimaryLabel,
    };
  }
}

class FloraFeedbackAttributes {
  const FloraFeedbackAttributes({
    required this.type,
    this.title,
    this.description,
    this.primaryAction,
    this.primaryActionLabel,
    this.secondaryAction,
    this.secondaryActionLabel,
  });

  final FloraFeedbackType type;
  final String? title;
  final String? description;
  final VoidCallback? primaryAction;
  final String? primaryActionLabel;
  final VoidCallback? secondaryAction;
  final String? secondaryActionLabel;
}
