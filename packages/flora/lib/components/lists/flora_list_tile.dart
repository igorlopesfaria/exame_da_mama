/// Flora DS — List Tile Components
library;

import 'package:flutter/material.dart';
import 'flora_list_tile_attributes.dart';
import 'flora_list_tile_style.dart';

class FloraListTile extends StatelessWidget {
  FloraListTile({
    super.key,
    required Widget title,
    Widget? subtitle,
    Widget? leading,
    Widget? trailing,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    bool selected = false,
    bool enabled = true,
    bool isThreeLine = false,
    bool? dense,
    EdgeInsetsGeometry? contentPadding,
  }) : _attributes = FloraListTileAttributes(
         title: title,
         subtitle: subtitle,
         leading: leading,
         trailing: trailing,
         onTap: onTap,
         onLongPress: onLongPress,
         selected: selected,
         enabled: enabled,
         isThreeLine: isThreeLine,
         dense: dense,
         contentPadding: contentPadding,
       );

  final FloraListTileAttributes _attributes;

  @override
  Widget build(BuildContext context) => Theme(
    data: Theme.of(context).copyWith(listTileTheme: FloraListTileStyle.resolveTheme(context)),
    child: ListTile(
      title: _attributes.title,
      subtitle: _attributes.subtitle,
      leading: _attributes.leading,
      trailing: _attributes.trailing,
      onTap: _attributes.onTap,
      onLongPress: _attributes.onLongPress,
      selected: _attributes.selected,
      enabled: _attributes.enabled,
      isThreeLine: _attributes.isThreeLine,
      dense: _attributes.dense,
      contentPadding: _attributes.contentPadding,
    ),
  );
}

class FloraCheckboxListTile extends StatelessWidget {
  FloraCheckboxListTile({
    super.key,
    required bool? value,
    required ValueChanged<bool?>? onChanged,
    required Widget title,
    Widget? subtitle,
    Widget? secondary,
    bool tristate = false,
    bool isError = false,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.leading,
  }) : _attributes = FloraCheckboxListTileAttributes(
         value: value,
         onChanged: onChanged,
         title: title,
         subtitle: subtitle,
         secondary: secondary,
         tristate: tristate,
         isError: isError,
         controlAffinity: controlAffinity,
       );

  final FloraCheckboxListTileAttributes _attributes;

  @override
  Widget build(BuildContext context) => Theme(
    data: Theme.of(context).copyWith(listTileTheme: FloraListTileStyle.resolveTheme(context)),
    child: CheckboxListTile(
      value: _attributes.value,
      onChanged: _attributes.onChanged,
      title: _attributes.title,
      subtitle: _attributes.subtitle,
      secondary: _attributes.secondary,
      tristate: _attributes.tristate,
      isError: _attributes.isError,
      controlAffinity: _attributes.controlAffinity,
    ),
  );
}

class FloraRadioListTile<T> extends StatelessWidget {
  FloraRadioListTile({
    super.key,
    required T value,
    required T? groupValue,
    required ValueChanged<T?>? onChanged,
    required Widget title,
    Widget? subtitle,
    Widget? secondary,
    bool toggleable = false,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.leading,
  }) : _attributes = FloraRadioListTileAttributes<T>(
         value: value,
         groupValue: groupValue,
         onChanged: onChanged,
         title: title,
         subtitle: subtitle,
         secondary: secondary,
         toggleable: toggleable,
         controlAffinity: controlAffinity,
       );

  final FloraRadioListTileAttributes<T> _attributes;

  @override
  Widget build(BuildContext context) => Theme(
    data: Theme.of(context).copyWith(listTileTheme: FloraListTileStyle.resolveTheme(context)),
    child: RadioListTile<T>(
      value: _attributes.value,
      groupValue: _attributes.groupValue,
      onChanged: _attributes.onChanged,
      title: _attributes.title,
      subtitle: _attributes.subtitle,
      secondary: _attributes.secondary,
      toggleable: _attributes.toggleable,
      controlAffinity: _attributes.controlAffinity,
    ),
  );
}

class FloraSwitchListTile extends StatelessWidget {
  FloraSwitchListTile({
    super.key,
    required bool value,
    required ValueChanged<bool>? onChanged,
    required Widget title,
    Widget? subtitle,
    Widget? secondary,
  }) : _attributes = FloraSwitchListTileAttributes(
         value: value,
         onChanged: onChanged,
         title: title,
         subtitle: subtitle,
         secondary: secondary,
       );

  final FloraSwitchListTileAttributes _attributes;

  @override
  Widget build(BuildContext context) => Theme(
    data: Theme.of(context).copyWith(listTileTheme: FloraListTileStyle.resolveTheme(context)),
    child: SwitchListTile(
      value: _attributes.value,
      onChanged: _attributes.onChanged,
      title: _attributes.title,
      subtitle: _attributes.subtitle,
      secondary: _attributes.secondary,
    ),
  );
}
