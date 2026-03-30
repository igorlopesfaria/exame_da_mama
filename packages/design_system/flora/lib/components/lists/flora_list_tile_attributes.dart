/// Flora DS — List Tile Attributes
library;

import 'package:flutter/material.dart';

enum FloraListTileVariant { standard, checkbox, radio, switcher }

class FloraListTileAttributes {
  const FloraListTileAttributes({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.selected = false,
    this.enabled = true,
    this.isThreeLine = false,
    this.dense,
    this.contentPadding,
  });

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool selected;
  final bool enabled;
  final bool isThreeLine;
  final bool? dense;
  final EdgeInsetsGeometry? contentPadding;
}

class FloraCheckboxListTileAttributes {
  const FloraCheckboxListTileAttributes({
    required this.value,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.secondary,
    this.tristate = false,
    this.isError = false,
    this.controlAffinity = ListTileControlAffinity.leading,
  });

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final Widget title;
  final Widget? subtitle;
  final Widget? secondary;
  final bool tristate;
  final bool isError;
  final ListTileControlAffinity controlAffinity;
}

class FloraRadioListTileAttributes<T> {
  const FloraRadioListTileAttributes({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.secondary,
    this.toggleable = false,
    this.controlAffinity = ListTileControlAffinity.leading,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final Widget title;
  final Widget? subtitle;
  final Widget? secondary;
  final bool toggleable;
  final ListTileControlAffinity controlAffinity;
}

class FloraSwitchListTileAttributes {
  const FloraSwitchListTileAttributes({
    required this.value,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.secondary,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget title;
  final Widget? subtitle;
  final Widget? secondary;
}