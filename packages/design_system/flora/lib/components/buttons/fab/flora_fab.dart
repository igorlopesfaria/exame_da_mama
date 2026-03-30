/// Flora DS — FloraFAB Component
library;

import 'package:flutter/material.dart';
import 'flora_fab_attributes.dart';

class FloraFAB extends StatelessWidget {
  FloraFAB({
    super.key,
    required Widget icon,
    required VoidCallback? onPressed,
    String? label,
    FloraFABSize size = FloraFABSize.regular,
    String? tooltip,
  }) : _attributes = FloraFABAttributes(
         icon: icon,
         onPressed: onPressed,
         size: size,
         label: label,
         tooltip: tooltip,
       );

  final FloraFABAttributes _attributes;

  @override
  Widget build(BuildContext context) {
    if (_attributes.label != null) {
      return FloatingActionButton.extended(
        onPressed: _attributes.onPressed,
        icon: _attributes.icon,
        label: Text(_attributes.label!),
        tooltip: _attributes.tooltip,
      );
    }
    return switch (_attributes.size) {
      FloraFABSize.small   => FloatingActionButton.small(onPressed: _attributes.onPressed, tooltip: _attributes.tooltip, child: _attributes.icon),
      FloraFABSize.large   => FloatingActionButton.large(onPressed: _attributes.onPressed, tooltip: _attributes.tooltip, child: _attributes.icon),
      FloraFABSize.regular => FloatingActionButton(onPressed: _attributes.onPressed, tooltip: _attributes.tooltip, child: _attributes.icon),
    };
  }
}
