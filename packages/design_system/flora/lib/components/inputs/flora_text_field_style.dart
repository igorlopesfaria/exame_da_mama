/// Flora DS — Text Field Style
library;

import 'package:flutter/material.dart';
import 'package:flora/core/tokens/flora_radius.dart';
import 'flora_text_field_attributes.dart';

abstract final class FloraTextFieldStyle {
  static InputDecoration decoration(BuildContext context, FloraTextFieldAttributes attrs) {
    final cs = Theme.of(context).colorScheme;
    final isOutlined = attrs.variant == FloraTextFieldVariant.outlined;

    return InputDecoration(
      labelText: attrs.label,
      hintText: attrs.hint,
      helperText: attrs.helperText,
      errorText: attrs.errorText,
      prefixIcon: attrs.prefixIcon,
      suffixIcon: attrs.suffixIcon,
      filled: !isOutlined,
      fillColor: !isOutlined ? cs.surfaceContainerHighest : null,
      border: isOutlined
          ? const OutlineInputBorder(borderRadius: FloraRadius.extraSmall)
          : const UnderlineInputBorder(borderRadius: FloraRadius.extraSmall),
      enabledBorder: isOutlined
          ? OutlineInputBorder(borderRadius: FloraRadius.extraSmall, borderSide: BorderSide(color: cs.outline))
          : UnderlineInputBorder(borderRadius: FloraRadius.extraSmall, borderSide: BorderSide(color: cs.onSurfaceVariant)),
      focusedBorder: isOutlined
          ? OutlineInputBorder(borderRadius: FloraRadius.extraSmall, borderSide: BorderSide(color: cs.primary, width: 2))
          : UnderlineInputBorder(borderRadius: FloraRadius.extraSmall, borderSide: BorderSide(color: cs.primary, width: 2)),
      errorBorder: isOutlined
          ? OutlineInputBorder(borderRadius: FloraRadius.extraSmall, borderSide: BorderSide(color: cs.error, width: 2))
          : UnderlineInputBorder(borderRadius: FloraRadius.extraSmall, borderSide: BorderSide(color: cs.error, width: 2)),
      disabledBorder: isOutlined
          ? OutlineInputBorder(borderRadius: FloraRadius.extraSmall, borderSide: BorderSide(color: cs.onSurface.withValues(alpha: 0.12)))
          : UnderlineInputBorder(borderRadius: FloraRadius.extraSmall, borderSide: BorderSide(color: cs.onSurface.withValues(alpha: 0.12))),
    );
  }
}
