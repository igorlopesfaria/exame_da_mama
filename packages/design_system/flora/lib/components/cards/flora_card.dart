/// Flora DS — Card Component
library;

import 'package:flutter/material.dart';
import 'flora_card_attributes.dart';
import 'flora_card_style.dart';

class FloraCard extends StatelessWidget {
  FloraCard({
    super.key,
    required Widget child,
    FloraCardVariant variant = FloraCardVariant.elevated,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    String? semanticLabel,
  }) : _attributes = FloraCardAttributes(
         child: child,
         variant: variant,
         onTap: onTap,
         onLongPress: onLongPress,
         padding: padding,
         margin: margin,
         semanticLabel: semanticLabel,
       );

  final FloraCardAttributes _attributes;

  @override
  Widget build(BuildContext context) {
    final theme = FloraCardStyle.resolveTheme(context, _attributes.variant);
    final content = _attributes.padding != null
        ? Padding(padding: _attributes.padding!, child: _attributes.child)
        : _attributes.child;
    final card = Theme(
      data: Theme.of(context).copyWith(cardTheme: theme),
      child: switch (_attributes.variant) {
        FloraCardVariant.elevated => Card(margin: _attributes.margin, child: content),
        FloraCardVariant.filled   => Card.filled(margin: _attributes.margin, child: content),
        FloraCardVariant.outlined => Card.outlined(margin: _attributes.margin, child: content),
      },
    );
    if (_attributes.onTap == null && _attributes.onLongPress == null) return card;
    return GestureDetector(
      onTap: _attributes.onTap,
      onLongPress: _attributes.onLongPress,
      child: card,
    );
  }
}
