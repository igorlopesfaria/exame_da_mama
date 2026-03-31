/// Flora DS — FloraButton Component
library;

import 'package:flutter/material.dart';
import 'package:flora/components/buttons/button/flora_button_attributes.dart';
import 'package:flora/components/buttons/button/flora_button_style.dart';

class FloraButton extends StatelessWidget {
  FloraButton({
    super.key,
    required String label,
    required VoidCallback? onPressed,
    FloraButtonVariant variant = FloraButtonVariant.filled,
    FloraButtonSize size = FloraButtonSize.medium,
    Widget? leadingIcon,
    Widget? trailingIcon,
    bool isLoading = false,
    String? tooltip,
  }) : _attributes = FloraButtonAttributes(
         label: label,
         onPressed: onPressed,
         variant: variant,
         size: size,
         leadingIcon: leadingIcon,
         trailingIcon: trailingIcon,
         isLoading: isLoading,
         tooltip: tooltip,
       );

  final FloraButtonAttributes _attributes;

  Widget _buildChild(BuildContext context) {
    if (_attributes.isLoading) {
      return SizedBox.square(
        dimension: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          color: FloraButtonStyle.loadingColor(context, _attributes.variant),
        ),
      );
    }
    if (_attributes.leadingIcon == null && _attributes.trailingIcon == null) {
      return Text(_attributes.label);
    }
    return Row(mainAxisSize: MainAxisSize.min, children: [
      if (_attributes.leadingIcon != null) ...[_attributes.leadingIcon!, const SizedBox(width: 8)],
      Text(_attributes.label),
      if (_attributes.trailingIcon != null) ...[const SizedBox(width: 8), _attributes.trailingIcon!],
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final style = FloraButtonStyle.resolve(context, _attributes.variant, _attributes.size);
    final child = _buildChild(context);
    final effectiveOnPressed = _attributes.isEnabled ? _attributes.onPressed : null;

    Widget button = switch (_attributes.variant) {
      FloraButtonVariant.filled   => FilledButton(style: style, onPressed: effectiveOnPressed, child: child),
      FloraButtonVariant.tonal    => FilledButton.tonal(style: style, onPressed: effectiveOnPressed, child: child),
      FloraButtonVariant.outlined => OutlinedButton(style: style, onPressed: effectiveOnPressed, child: child),
      FloraButtonVariant.text     => TextButton(style: style, onPressed: effectiveOnPressed, child: child),
      FloraButtonVariant.elevated => ElevatedButton(style: style, onPressed: effectiveOnPressed, child: child),
    };

    if (_attributes.tooltip != null) button = Tooltip(message: _attributes.tooltip!, child: button);
    return button;
  }
}
