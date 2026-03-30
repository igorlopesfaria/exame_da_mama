/// Flora DS — App Bar Attributes
library;

import 'package:flutter/widgets.dart';

enum FloraAppBarVariant { small, medium, large }

class FloraAppBarAttributes {
  const FloraAppBarAttributes({
    required this.variant,
    this.title,
    this.leading,
    this.actions,
    this.centerTitle,
    this.backgroundColor,
    this.scrolledUnderElevation,
    this.automaticallyImplyLeading = true,
    this.bottom,
  });

  final FloraAppBarVariant variant;
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTitle;
  final Color? backgroundColor;
  final double? scrolledUnderElevation;
  final bool automaticallyImplyLeading;
  final PreferredSizeWidget? bottom;
}