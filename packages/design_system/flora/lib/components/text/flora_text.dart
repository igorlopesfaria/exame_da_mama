/// Flora DS — FloraText Component
library;

import 'package:flutter/material.dart';
import 'package:flora/components/text/flora_text_attributes.dart';
import 'package:flora/components/text/flora_text_style_resolver.dart';

class FloraText extends StatelessWidget {
  FloraText(
    String text, {
    super.key,
    FloraTextStyle style = FloraTextStyle.bodyMedium,
    FloraTextColor color = FloraTextColor.primary,
    FloraTextAlign? align,
    FloraTextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    TextStyle? overrideStyle,
    String? semanticsLabel,
  }) : _attributes = FloraTextAttributes(
         text: text,
         style: style,
         color: color,
         align: align,
         overflow: overflow,
         maxLines: maxLines,
         softWrap: softWrap,
         overrideStyle: overrideStyle,
         semanticsLabel: semanticsLabel,
       );

  FloraText.displayLarge(
    String text, {
    super.key,
    FloraTextColor color = FloraTextColor.primary,
    FloraTextAlign? align,
    FloraTextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    TextStyle? overrideStyle,
    String? semanticsLabel,
  }) : _attributes = FloraTextAttributes(
         text: text,
         style: FloraTextStyle.displayLarge,
         color: color,
         align: align,
         overflow: overflow,
         maxLines: maxLines,
         softWrap: softWrap,
         overrideStyle: overrideStyle,
         semanticsLabel: semanticsLabel,
       );

  FloraText.displayMedium(
    String text, {
    super.key,
    FloraTextColor color = FloraTextColor.primary,
    FloraTextAlign? align,
    FloraTextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    TextStyle? overrideStyle,
    String? semanticsLabel,
  }) : _attributes = FloraTextAttributes(
         text: text,
         style: FloraTextStyle.displayMedium,
         color: color,
         align: align,
         overflow: overflow,
         maxLines: maxLines,
         softWrap: softWrap,
         overrideStyle: overrideStyle,
         semanticsLabel: semanticsLabel,
       );

  FloraText.displaySmall(
    String text, {
    super.key,
    FloraTextColor color = FloraTextColor.primary,
    FloraTextAlign? align,
    FloraTextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    TextStyle? overrideStyle,
    String? semanticsLabel,
  }) : _attributes = FloraTextAttributes(
         text: text,
         style: FloraTextStyle.displaySmall,
         color: color,
         align: align,
         overflow: overflow,
         maxLines: maxLines,
         softWrap: softWrap,
         overrideStyle: overrideStyle,
         semanticsLabel: semanticsLabel,
       );

  FloraText.headlineLarge(
    String text, {
    super.key,
    FloraTextColor color = FloraTextColor.primary,
    FloraTextAlign? align,
    FloraTextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    TextStyle? overrideStyle,
    String? semanticsLabel,
  }) : _attributes = FloraTextAttributes(
         text: text,
         style: FloraTextStyle.headlineLarge,
         color: color,
         align: align,
         overflow: overflow,
         maxLines: maxLines,
         softWrap: softWrap,
         overrideStyle: overrideStyle,
         semanticsLabel: semanticsLabel,
       );

  FloraText.headlineMedium(
    String text, {
    super.key,
    FloraTextColor color = FloraTextColor.primary,
    FloraTextAlign? align,
    FloraTextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    TextStyle? overrideStyle,
    String? semanticsLabel,
  }) : _attributes = FloraTextAttributes(
         text: text,
         style: FloraTextStyle.headlineMedium,
         color: color,
         align: align,
         overflow: overflow,
         maxLines: maxLines,
         softWrap: softWrap,
         overrideStyle: overrideStyle,
         semanticsLabel: semanticsLabel,
       );

  FloraText.headlineSmall(
    String text, {
    super.key,
    FloraTextColor color = FloraTextColor.primary,
    FloraTextAlign? align,
    FloraTextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    TextStyle? overrideStyle,
    String? semanticsLabel,
  }) : _attributes = FloraTextAttributes(
         text: text,
         style: FloraTextStyle.headlineSmall,
         color: color,
         align: align,
         overflow: overflow,
         maxLines: maxLines,
         softWrap: softWrap,
         overrideStyle: overrideStyle,
         semanticsLabel: semanticsLabel,
       );

  FloraText.titleLarge(
    String text, {
    super.key,
    FloraTextColor color = FloraTextColor.primary,
    FloraTextAlign? align,
    FloraTextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    TextStyle? overrideStyle,
    String? semanticsLabel,
  }) : _attributes = FloraTextAttributes(
         text: text,
         style: FloraTextStyle.titleLarge,
         color: color,
         align: align,
         overflow: overflow,
         maxLines: maxLines,
         softWrap: softWrap,
         overrideStyle: overrideStyle,
         semanticsLabel: semanticsLabel,
       );

  FloraText.titleMedium(
    String text, {
    super.key,
    FloraTextColor color = FloraTextColor.primary,
    FloraTextAlign? align,
    FloraTextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    TextStyle? overrideStyle,
    String? semanticsLabel,
  }) : _attributes = FloraTextAttributes(
         text: text,
         style: FloraTextStyle.titleMedium,
         color: color,
         align: align,
         overflow: overflow,
         maxLines: maxLines,
         softWrap: softWrap,
         overrideStyle: overrideStyle,
         semanticsLabel: semanticsLabel,
       );

  FloraText.titleSmall(
    String text, {
    super.key,
    FloraTextColor color = FloraTextColor.primary,
    FloraTextAlign? align,
    FloraTextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    TextStyle? overrideStyle,
    String? semanticsLabel,
  }) : _attributes = FloraTextAttributes(
         text: text,
         style: FloraTextStyle.titleSmall,
         color: color,
         align: align,
         overflow: overflow,
         maxLines: maxLines,
         softWrap: softWrap,
         overrideStyle: overrideStyle,
         semanticsLabel: semanticsLabel,
       );

  FloraText.labelLarge(
    String text, {
    super.key,
    FloraTextColor color = FloraTextColor.primary,
    FloraTextAlign? align,
    FloraTextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    TextStyle? overrideStyle,
    String? semanticsLabel,
  }) : _attributes = FloraTextAttributes(
         text: text,
         style: FloraTextStyle.labelLarge,
         color: color,
         align: align,
         overflow: overflow,
         maxLines: maxLines,
         softWrap: softWrap,
         overrideStyle: overrideStyle,
         semanticsLabel: semanticsLabel,
       );

  FloraText.labelMedium(
    String text, {
    super.key,
    FloraTextColor color = FloraTextColor.primary,
    FloraTextAlign? align,
    FloraTextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    TextStyle? overrideStyle,
    String? semanticsLabel,
  }) : _attributes = FloraTextAttributes(
         text: text,
         style: FloraTextStyle.labelMedium,
         color: color,
         align: align,
         overflow: overflow,
         maxLines: maxLines,
         softWrap: softWrap,
         overrideStyle: overrideStyle,
         semanticsLabel: semanticsLabel,
       );

  FloraText.labelSmall(
    String text, {
    super.key,
    FloraTextColor color = FloraTextColor.primary,
    FloraTextAlign? align,
    FloraTextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    TextStyle? overrideStyle,
    String? semanticsLabel,
  }) : _attributes = FloraTextAttributes(
         text: text,
         style: FloraTextStyle.labelSmall,
         color: color,
         align: align,
         overflow: overflow,
         maxLines: maxLines,
         softWrap: softWrap,
         overrideStyle: overrideStyle,
         semanticsLabel: semanticsLabel,
       );

  FloraText.bodyLarge(
    String text, {
    super.key,
    FloraTextColor color = FloraTextColor.primary,
    FloraTextAlign? align,
    FloraTextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    TextStyle? overrideStyle,
    String? semanticsLabel,
  }) : _attributes = FloraTextAttributes(
         text: text,
         style: FloraTextStyle.bodyLarge,
         color: color,
         align: align,
         overflow: overflow,
         maxLines: maxLines,
         softWrap: softWrap,
         overrideStyle: overrideStyle,
         semanticsLabel: semanticsLabel,
       );

  FloraText.bodyMedium(
    String text, {
    super.key,
    FloraTextColor color = FloraTextColor.primary,
    FloraTextAlign? align,
    FloraTextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    TextStyle? overrideStyle,
    String? semanticsLabel,
  }) : _attributes = FloraTextAttributes(
         text: text,
         style: FloraTextStyle.bodyMedium,
         color: color,
         align: align,
         overflow: overflow,
         maxLines: maxLines,
         softWrap: softWrap,
         overrideStyle: overrideStyle,
         semanticsLabel: semanticsLabel,
       );

  FloraText.bodySmall(
    String text, {
    super.key,
    FloraTextColor color = FloraTextColor.primary,
    FloraTextAlign? align,
    FloraTextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    TextStyle? overrideStyle,
    String? semanticsLabel,
  }) : _attributes = FloraTextAttributes(
         text: text,
         style: FloraTextStyle.bodySmall,
         color: color,
         align: align,
         overflow: overflow,
         maxLines: maxLines,
         softWrap: softWrap,
         overrideStyle: overrideStyle,
         semanticsLabel: semanticsLabel,
       );

  final FloraTextAttributes _attributes;

  @override
  Widget build(BuildContext context) => Text(
    _attributes.text,
    style: FloraTextStyleResolver.merge(
      context,
      style: _attributes.style,
      color: _attributes.color,
      overrideStyle: _attributes.overrideStyle,
    ),
    textAlign: FloraTextStyleResolver.resolveAlign(_attributes.align),
    overflow: FloraTextStyleResolver.resolveOverflow(_attributes.overflow),
    maxLines: _attributes.maxLines,
    softWrap: _attributes.softWrap,
    semanticsLabel: _attributes.semanticsLabel,
  );
}
