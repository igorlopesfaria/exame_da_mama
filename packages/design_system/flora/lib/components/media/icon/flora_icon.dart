/// Flora DS Media — FloraIcon Component
library;

import 'package:flutter/material.dart';
import 'flora_icon_attributes.dart';
import 'flora_icon_style.dart';

class FloraIcon extends StatelessWidget {
  FloraIcon.flutter(
    IconData iconData, {
    super.key,
    double? size,
    FloraIconColor color = FloraIconColor.primary,
    String? semanticLabel,
  }) : _attributes = FloraIconAttributes(
         variant: FloraIconVariant.flutter,
         iconData: iconData,
         size: size,
         color: color,
         semanticLabel: semanticLabel,
       );

  FloraIcon.asset(
    String path, {
    super.key,
    double? size,
    FloraIconColor color = FloraIconColor.primary,
    String? semanticLabel,
  }) : _attributes = FloraIconAttributes(
         variant: FloraIconVariant.asset,
         assetPath: path,
         size: size,
         color: color,
         semanticLabel: semanticLabel,
       );

  final FloraIconAttributes _attributes;

  @override
  Widget build(BuildContext context) {
    final resolvedColor = FloraIconStyle.resolveColor(context, _attributes.color);
    final resolvedSize  = FloraIconStyle.resolveSize(_attributes.size);

    return switch (_attributes.variant) {
      FloraIconVariant.flutter => Icon(
          _attributes.iconData,
          size: resolvedSize,
          color: resolvedColor,
          semanticLabel: _attributes.semanticLabel,
        ),
      FloraIconVariant.asset => Image.asset(
          _attributes.assetPath!,
          width: resolvedSize,
          height: resolvedSize,
          color: resolvedColor,
          semanticLabel: _attributes.semanticLabel,
        ),
    };
  }
}
