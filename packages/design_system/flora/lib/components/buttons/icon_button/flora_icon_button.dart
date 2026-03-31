/// Flora DS — FloraIconButton Component
library;

import 'package:flutter/material.dart';
import 'flora_icon_button_attributes.dart';

class FloraIconButton extends StatelessWidget {
  FloraIconButton({
    super.key,
    required Widget icon,
    required VoidCallback? onPressed,
    FloraIconButtonVariant variant = FloraIconButtonVariant.standard,
    bool isSelected = false,
    Widget? selectedIcon,
    String? tooltip,
  }) : _attributes = FloraIconButtonAttributes(
         icon: icon,
         onPressed: onPressed,
         variant: variant,
         isSelected: isSelected,
         selectedIcon: selectedIcon,
         tooltip: tooltip,
       );

  final FloraIconButtonAttributes _attributes;

  @override
  Widget build(BuildContext context) => switch (_attributes.variant) {
    FloraIconButtonVariant.filled   => IconButton.filled(icon: _attributes.icon, onPressed: _attributes.onPressed, isSelected: _attributes.isSelected, selectedIcon: _attributes.selectedIcon, tooltip: _attributes.tooltip),
    FloraIconButtonVariant.tonal    => IconButton.filledTonal(icon: _attributes.icon, onPressed: _attributes.onPressed, isSelected: _attributes.isSelected, selectedIcon: _attributes.selectedIcon, tooltip: _attributes.tooltip),
    FloraIconButtonVariant.outlined => IconButton.outlined(icon: _attributes.icon, onPressed: _attributes.onPressed, isSelected: _attributes.isSelected, selectedIcon: _attributes.selectedIcon, tooltip: _attributes.tooltip),
    FloraIconButtonVariant.standard => IconButton(icon: _attributes.icon, onPressed: _attributes.onPressed, isSelected: _attributes.isSelected, selectedIcon: _attributes.selectedIcon, tooltip: _attributes.tooltip),
  };
}
