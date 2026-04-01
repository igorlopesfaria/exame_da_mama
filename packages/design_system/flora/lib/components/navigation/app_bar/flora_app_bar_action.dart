/// Flora DS — App Bar Action descriptor
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Describes a single icon-button action rendered in [FloraAppBar.actions].
///
/// Provide either [flutterIcon] (a Material [IconData]) or [assetIcon]
/// (a bundled asset path). Exactly one must be non-null.
@immutable
class FloraAppBarAction {
  const FloraAppBarAction({
    this.flutterIcon,
    this.assetIcon,
    required this.onPressed,
    this.tooltip,
    this.badgeCount,
  }) : assert(
         flutterIcon != null || assetIcon != null,
         'FloraAppBarAction requires either flutterIcon or assetIcon',
       );

  /// A Material / Cupertino icon glyph.
  final IconData? flutterIcon;

  /// A bundled asset image path (e.g. from FloraIconAssets).
  final String? assetIcon;

  /// Callback invoked when the button is tapped. Pass null to disable.
  final VoidCallback? onPressed;

  /// Tooltip / accessibility label for the button.
  final String? tooltip;

  /// When non-null, overlays a [Badge] on the icon.
  /// - `0`  → dot badge (unread indicator without count)
  /// - `>0` → numbered badge
  final int? badgeCount;
}
