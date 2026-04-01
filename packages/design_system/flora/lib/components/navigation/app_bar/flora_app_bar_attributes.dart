/// Flora DS — App Bar Attributes
library;

import 'package:flora/components/navigation/app_bar/flora_app_bar_action.dart';
import 'package:flutter/widgets.dart';

enum FloraAppBarVariant { small, medium, large }

class FloraAppBarAttributes {
  const FloraAppBarAttributes({
    required this.variant,
    this.title,
    this.leadingFlutterIcon,
    this.leadingAssetIcon,
    this.onLeadingPressed,
    this.actions,
    this.centerTitle,
    this.backgroundColor,
    this.scrolledUnderElevation,
    this.automaticallyImplyLeading = true,
    this.bottom,
    this.currentStep,
    this.totalSteps,
  });

  final FloraAppBarVariant variant;

  /// Plain text rendered internally as [FloraText] with the correct style
  /// for each [variant].
  final String? title;

  /// Leading icon as a Material [IconData]. Takes precedence over
  /// [leadingAssetIcon] when both are provided.
  final IconData? leadingFlutterIcon;

  /// Leading icon as a bundled asset path.
  final String? leadingAssetIcon;

  /// Callback for the leading icon button. When null the icon is decorative.
  final VoidCallback? onLeadingPressed;

  /// Action buttons rendered as [FloraIconButton]s in the trailing area.
  final List<FloraAppBarAction>? actions;

  final bool? centerTitle;
  final Color? backgroundColor;
  final double? scrolledUnderElevation;
  final bool automaticallyImplyLeading;
  final PreferredSizeWidget? bottom;

  /// Current step (1-based). When both [currentStep] and [totalSteps] are
  /// non-null, a [FloraProgressStep] is rendered instead of [title].
  final int? currentStep;

  /// Total number of steps. See [currentStep].
  final int? totalSteps;

  FloraAppBarAttributes copyWith({
    FloraAppBarVariant? variant,
    String? title,
    IconData? leadingFlutterIcon,
    String? leadingAssetIcon,
    VoidCallback? onLeadingPressed,
    List<FloraAppBarAction>? actions,
    bool? centerTitle,
    Color? backgroundColor,
    double? scrolledUnderElevation,
    bool? automaticallyImplyLeading,
    PreferredSizeWidget? bottom,
    int? currentStep,
    int? totalSteps,
  }) {
    return FloraAppBarAttributes(
      variant: variant ?? this.variant,
      title: title ?? this.title,
      leadingFlutterIcon: leadingFlutterIcon ?? this.leadingFlutterIcon,
      leadingAssetIcon: leadingAssetIcon ?? this.leadingAssetIcon,
      onLeadingPressed: onLeadingPressed ?? this.onLeadingPressed,
      actions: actions ?? this.actions,
      centerTitle: centerTitle ?? this.centerTitle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      scrolledUnderElevation:
          scrolledUnderElevation ?? this.scrolledUnderElevation,
      automaticallyImplyLeading:
          automaticallyImplyLeading ?? this.automaticallyImplyLeading,
      bottom: bottom ?? this.bottom,
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
    );
  }
}
