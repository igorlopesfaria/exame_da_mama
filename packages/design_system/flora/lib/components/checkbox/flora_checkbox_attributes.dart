/// Flora DS — Checkbox Attributes
library;

import 'package:flutter/widgets.dart';

class FloraCheckboxAttributes {
  const FloraCheckboxAttributes({
    required this.value,
    required this.onChanged,
    this.label,
    this.tristate = false,
    this.isError = false,
    this.enabled = true,
  });

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final String? label;
  final bool tristate;
  final bool isError;
  final bool enabled;
}