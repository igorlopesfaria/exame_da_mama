/// Flora DS — Text Field Component
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'flora_text_field_attributes.dart';
import 'flora_text_field_style.dart';

class FloraTextField extends StatelessWidget {
  FloraTextField({
    super.key,
    required String label,
    this.controller,
    this.focusNode,
    String? hint,
    String? helperText,
    String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool obscureText = false,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onTap,
    bool readOnly = false,
    bool enabled = true,
    int? maxLines = 1,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    FloraTextFieldVariant variant = FloraTextFieldVariant.outlined,
    bool autofocus = false,
  }) : _attributes = FloraTextFieldAttributes(
         label: label,
         hint: hint,
         helperText: helperText,
         errorText: errorText,
         prefixIcon: prefixIcon,
         suffixIcon: suffixIcon,
         obscureText: obscureText,
         keyboardType: keyboardType,
         textInputAction: textInputAction,
         onChanged: onChanged,
         onSubmitted: onSubmitted,
         onTap: onTap,
         readOnly: readOnly,
         enabled: enabled,
         maxLines: maxLines,
         maxLength: maxLength,
         inputFormatters: inputFormatters,
         variant: variant,
         autofocus: autofocus,
       );

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FloraTextFieldAttributes _attributes;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      obscureText: _attributes.obscureText,
      keyboardType: _attributes.keyboardType,
      textInputAction: _attributes.textInputAction,
      onChanged: _attributes.onChanged,
      onSubmitted: _attributes.onSubmitted,
      onTap: _attributes.onTap,
      readOnly: _attributes.readOnly,
      enabled: _attributes.enabled,
      maxLines: _attributes.obscureText ? 1 : _attributes.maxLines,
      maxLength: _attributes.maxLength,
      inputFormatters: _attributes.inputFormatters,
      autofocus: _attributes.autofocus,
      decoration: FloraTextFieldStyle.decoration(context, _attributes),
    );
  }
}
