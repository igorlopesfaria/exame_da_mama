/// Flora DS — App Bar Component
library;

import 'package:flutter/material.dart';
import 'package:flora/components/buttons/icon_button/flora_icon_button.dart';
import 'package:flora/components/media/icon/flora_icon.dart';
import 'package:flora/components/navigation/app_bar/flora_app_bar_action.dart';
import 'package:flora/components/navigation/app_bar/flora_app_bar_attributes.dart';
import 'package:flora/components/navigation/app_bar/flora_app_bar_style.dart';
import 'package:flora/components/progress/step/flora_progress_step.dart';
import 'package:flora/components/text/flora_text.dart';

export 'flora_app_bar_action.dart';
export 'flora_app_bar_attributes.dart';
export 'flora_app_bar_style.dart';

class FloraAppBar extends StatelessWidget implements PreferredSizeWidget {
  FloraAppBar({
    super.key,
    String? title,
    IconData? leadingFlutterIcon,
    String? leadingAssetIcon,
    VoidCallback? onLeadingPressed,
    List<FloraAppBarAction>? actions,
    bool? centerTitle,
    PreferredSizeWidget? bottom,
    Color? backgroundColor,
    double? scrolledUnderElevation,
    bool automaticallyImplyLeading = true,
    FloraAppBarVariant variant = FloraAppBarVariant.small,
    int? currentStep,
    int? totalSteps,
  }) : _attributes = FloraAppBarAttributes(
         variant: variant,
         title: title,
         leadingFlutterIcon: leadingFlutterIcon,
         leadingAssetIcon: leadingAssetIcon,
         onLeadingPressed: onLeadingPressed,
         actions: actions,
         centerTitle: centerTitle,
         backgroundColor: backgroundColor,
         scrolledUnderElevation: scrolledUnderElevation,
         automaticallyImplyLeading: automaticallyImplyLeading,
         bottom: bottom,
         currentStep: currentStep,
         totalSteps: totalSteps,
       );

  final FloraAppBarAttributes _attributes;

  @override
  Size get preferredSize {
    final style = FloraAppBarStyle(_attributes);
    return Size.fromHeight(
      style.toolbarHeight + (_attributes.bottom?.preferredSize.height ?? 0),
    );
  }

  Widget? _buildTitle(FloraAppBarStyle style) {
    final title = _attributes.title;
    if (title == null) return null;
    return FloraText(title, style: style.titleTextStyle, maxLines: 1);
  }

  Widget? _buildLeading() {
    final flutterIcon = _attributes.leadingFlutterIcon;
    final assetIcon = _attributes.leadingAssetIcon;
    if (flutterIcon == null && assetIcon == null) return null;

    final icon = flutterIcon != null
        ? FloraIcon.flutter(flutterIcon)
        : FloraIcon.asset(assetIcon!);

    final callback = _attributes.onLeadingPressed;
    if (callback != null) {
      return FloraIconButton(icon: icon, onPressed: callback);
    }
    return icon;
  }

  List<Widget>? _buildActions() {
    final actions = _attributes.actions;
    if (actions == null || actions.isEmpty) return null;
    return actions.map(_buildAction).toList();
  }

  Widget _buildAction(FloraAppBarAction action) {
    final icon = action.flutterIcon != null
        ? FloraIcon.flutter(action.flutterIcon!)
        : FloraIcon.asset(action.assetIcon!);

    Widget button = FloraIconButton(
      icon: icon,
      onPressed: action.onPressed,
      tooltip: action.tooltip,
    );

    if (action.badgeCount != null) {
      button = Badge(
        label: action.badgeCount! > 0 ? Text(action.badgeCount.toString()) : null,
        child: button,
      );
    }

    return button;
  }

  @override
  Widget build(BuildContext context) {
    final style = FloraAppBarStyle(_attributes);

    final title = style.showProgressStep
        ? FloraProgressStep(
            totalSteps: style.progressStepAttributes.totalSteps,
            completedSteps: style.progressStepAttributes.completedSteps,
          )
        : _buildTitle(style);

    return AppBar(
      title: title,
      leading: _buildLeading(),
      actions: _buildActions(),
      centerTitle: style.showProgressStep ? false : _attributes.centerTitle,
      bottom: _attributes.bottom,
      backgroundColor: _attributes.backgroundColor,
      scrolledUnderElevation: _attributes.scrolledUnderElevation,
      automaticallyImplyLeading: _attributes.automaticallyImplyLeading,
      toolbarHeight: style.toolbarHeight,
      titleSpacing: style.showProgressStep ? 0 : NavigationToolbar.kMiddleSpacing,
    );
  }
}
