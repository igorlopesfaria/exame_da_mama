/// Flora DS — Toast Attributes
library;

import 'package:flutter/widgets.dart';

enum FloraToastVariant { info, success, warning, error }

enum FloraToastDuration { short, medium, long, persistent }

enum FloraToastPosition { bottom, top }

class FloraToastAttributes {
  const FloraToastAttributes({
    required this.message,
    required this.variant,
    required this.duration,
    required this.position,
    this.actionLabel,
    this.onAction,
    this.onDismissed,
    this.showCloseButton = false,
    this.leadingIcon,
  });

  final String message;
  final FloraToastVariant variant;
  final FloraToastDuration duration;
  final FloraToastPosition position;
  final String? actionLabel;
  final VoidCallback? onAction;
  final VoidCallback? onDismissed;
  final bool showCloseButton;
  final Widget? leadingIcon;

  Duration get effectiveDuration => switch (duration) {
    FloraToastDuration.short      => const Duration(seconds: 2),
    FloraToastDuration.medium     => const Duration(seconds: 4),
    FloraToastDuration.long       => const Duration(seconds: 8),
    FloraToastDuration.persistent => Duration.zero,
  };

  bool get isPersistent => duration == FloraToastDuration.persistent;
}
