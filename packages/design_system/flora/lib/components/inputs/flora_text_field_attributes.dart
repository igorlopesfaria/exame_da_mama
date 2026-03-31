/// Flora DS — Text Field Attributes
library;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

enum FloraTextFieldVariant { filled, outlined }

class FloraTextFieldAttributes {
  const FloraTextFieldAttributes({
    required this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.variant = FloraTextFieldVariant.filled,
    this.autofocus = false,
  });

  final String label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final FloraTextFieldVariant variant;
  final bool autofocus;
}
