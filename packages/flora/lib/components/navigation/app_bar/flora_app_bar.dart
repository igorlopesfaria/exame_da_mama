/// Flora DS — App Bar Component
library;

import 'package:flutter/material.dart';
import 'package:flora/components/navigation/app_bar/flora_app_bar_attributes.dart';
import 'package:flora/components/navigation/app_bar/flora_app_bar_style.dart';

export 'flora_app_bar_attributes.dart';
export 'flora_app_bar_style.dart';

class FloraAppBar extends StatelessWidget implements PreferredSizeWidget {
  FloraAppBar({
    super.key,
    Widget? title,
    Widget? leading,
    List<Widget>? actions,
    bool? centerTitle,
    PreferredSizeWidget? bottom,
    Color? backgroundColor,
    double? scrolledUnderElevation,
    bool automaticallyImplyLeading = true,
    FloraAppBarVariant variant = FloraAppBarVariant.small,
  }) : _attributes = FloraAppBarAttributes(
         variant: variant,
         title: title,
         leading: leading,
         actions: actions,
         centerTitle: centerTitle,
         backgroundColor: backgroundColor,
         scrolledUnderElevation: scrolledUnderElevation,
         automaticallyImplyLeading: automaticallyImplyLeading,
         bottom: bottom,
       );

  final FloraAppBarAttributes _attributes;

  @override
  Size get preferredSize => Size.fromHeight(
    FloraAppBarStyle.toolbarHeight(_attributes.variant) +
        (_attributes.bottom?.preferredSize.height ?? 0),
  );

  @override
  Widget build(BuildContext context) => AppBar(
    title: _attributes.title,
    leading: _attributes.leading,
    actions: _attributes.actions,
    centerTitle: _attributes.centerTitle,
    bottom: _attributes.bottom,
    backgroundColor: _attributes.backgroundColor,
    scrolledUnderElevation: _attributes.scrolledUnderElevation,
    automaticallyImplyLeading: _attributes.automaticallyImplyLeading,
    toolbarHeight: FloraAppBarStyle.toolbarHeight(_attributes.variant),
  );
}
