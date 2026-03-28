/// Flora DS — FloraSwitch Component
library;

import 'package:flutter/material.dart';
import 'package:flora/components/switch/flora_switch_attributes.dart';
import 'package:flora/components/switch/flora_switch_style.dart';

class FloraSwitch extends StatelessWidget {
  FloraSwitch({
    super.key,
    required bool value,
    required ValueChanged<bool>? onChanged,
    String? label,
    WidgetStateProperty<Icon?>? thumbIcon,
    bool enabled = true,
  }) : _attributes = FloraSwitchAttributes(
         value: value,
         onChanged: onChanged,
         label: label,
         thumbIcon: thumbIcon,
         enabled: enabled,
       );

  final FloraSwitchAttributes _attributes;

  ValueChanged<bool>? get _effectiveOnChanged =>
      _attributes.enabled ? _attributes.onChanged : null;

  @override
  Widget build(BuildContext context) {
    final switcher = Switch(
      value: _attributes.value,
      onChanged: _effectiveOnChanged,
      thumbIcon: _attributes.thumbIcon,
      overlayColor: FloraSwitchStyle.overlayColor(context),
    );

    if (_attributes.label == null) return switcher;

    return InkWell(
      onTap: _effectiveOnChanged == null
          ? null
          : () => _effectiveOnChanged!(!_attributes.value),
      borderRadius: BorderRadius.circular(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          const SizedBox(width: 8),
          switcher,
        ],
      ),
    );
  }
}
