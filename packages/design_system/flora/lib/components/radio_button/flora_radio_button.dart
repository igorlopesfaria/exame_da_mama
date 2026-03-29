/// Flora DS — FloraRadioButton Component
library;

import 'package:flutter/material.dart';
import 'package:flora/components/radio_button/flora_radio_button_attributes.dart';
import 'package:flora/components/radio_button/flora_radio_button_style.dart';

class FloraRadioButton<T> extends StatelessWidget {
  FloraRadioButton({
    super.key,
    required T value,
    required T? groupValue,
    required void Function(T?)? onChanged,
    String? label,
    bool toggleable = false,
    bool enabled = true,
  }) : _attributes = FloraRadioButtonAttributes<T>(
         value: value,
         groupValue: groupValue,
         onChanged: onChanged,
         label: label,
         toggleable: toggleable,
         enabled: enabled,
       );

  final FloraRadioButtonAttributes<T> _attributes;

  void Function(T?)? get _effectiveOnChanged =>
      _attributes.enabled ? _attributes.onChanged : null;

  @override
  Widget build(BuildContext context) {
    final radio = Radio<T>(
      value: _attributes.value,
      groupValue: _attributes.groupValue,
      onChanged: _attributes.onChanged,
      toggleable: _attributes.toggleable,
      fillColor: FloraRadioButtonStyle.fillColor(context),
      overlayColor: FloraRadioButtonStyle.overlayColor(context),
    );

    if (_attributes.label == null) return radio;

    return InkWell(
      onTap: _effectiveOnChanged == null
          ? null
          : () => _effectiveOnChanged!(_attributes.value),
      borderRadius: BorderRadius.circular(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          radio,
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              _attributes.label!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: _attributes.enabled
                        ? null
                        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.38),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
