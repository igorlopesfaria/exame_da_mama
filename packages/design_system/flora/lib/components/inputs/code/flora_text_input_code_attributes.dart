/// Flora DS — Text Input Code Attributes
library;

import 'package:flutter/material.dart';

enum FloraTextInputCodeVariant { outlined, filled }

class FloraTextInputCodeAttributes {
  const FloraTextInputCodeAttributes({
    required this.length,
    required this.controllers,
    required this.focusNodes,
    this.variant = FloraTextInputCodeVariant.outlined,
    this.obscureText = false,
    this.onCompleted,
    this.onChanged,
    this.errorText,
  });

  final int length;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final FloraTextInputCodeVariant variant;
  final bool obscureText;
  final void Function(String code)? onCompleted;
  final void Function(String code)? onChanged;
  final String? errorText;
}
