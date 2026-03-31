/// Flora DS — Switch Attributes
library;

import 'package:flutter/material.dart';

class FloraSwitchAttributes {
  const FloraSwitchAttributes({
    required this.value,
    required this.onChanged,
    this.label,
    this.thumbIcon,
    this.enabled = true,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final WidgetStateProperty<Icon?>? thumbIcon;
  final bool enabled;
}