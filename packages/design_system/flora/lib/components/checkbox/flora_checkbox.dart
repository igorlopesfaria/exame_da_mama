/// Flora DS — FloraCheckbox Component
library;

import 'package:flutter/material.dart';
import 'flora_checkbox_attributes.dart';
import 'flora_checkbox_style.dart';

class FloraCheckbox extends StatelessWidget {
  FloraCheckbox({
    super.key,
    required bool? value,
    required ValueChanged<bool?>? onChanged,
    String? label,
    bool tristate = false,
    bool isError = false,
    bool enabled = true,
  }) : _attributes = FloraCheckboxAttributes(
         value: value,
         onChanged: onChanged,
         label: label,
         tristate: tristate,
         isError: isError,
         enabled: enabled,
       );

  final FloraCheckboxAttributes _attributes;

  ValueChanged<bool?>? get _effectiveOnChanged =>
      _attributes.enabled ? _attributes.onChanged : null;

  @override
  Widget build(BuildContext context) {
    final checkbox = Checkbox(
      value: _attributes.value,
      onChanged: _effectiveOnChanged,
      tristate: _attributes.tristate,
      isError: _attributes.isError,
      fillColor: FloraCheckboxStyle.fillColor(context),
      overlayColor: FloraCheckboxStyle.overlayColor(context),
    );

    if (_attributes.label == null) return checkbox;

    return InkWell(
      onTap: _effectiveOnChanged == null
          ? null
          : () => _effectiveOnChanged!(!(_attributes.value ?? false)),
      borderRadius: BorderRadius.circular(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          checkbox,
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
