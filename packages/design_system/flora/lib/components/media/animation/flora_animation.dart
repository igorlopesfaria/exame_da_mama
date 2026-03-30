/// Flora DS Media — FloraAnimation Component
library;

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'flora_animation_attributes.dart';
import 'flora_animation_style.dart';

class FloraAnimation extends StatelessWidget {
  FloraAnimation.asset(
    String path, {
    super.key,
    double? width,
    double? height,
    FloraAnimationFit fit = FloraAnimationFit.contain,
    bool repeat = true,
    bool reverse = false,
    bool animate = true,
    VoidCallback? onLoaded,
    String? semanticLabel,
  }) : _attributes = FloraAnimationAttributes(
         assetPath: path,
         width: width,
         height: height,
         fit: fit,
         repeat: repeat,
         reverse: reverse,
         animate: animate,
         onLoaded: onLoaded,
         semanticLabel: semanticLabel,
       );

  final FloraAnimationAttributes _attributes;

  @override
  Widget build(BuildContext context) {
    final animation = Lottie.asset(
      _attributes.assetPath,
      width: _attributes.width,
      height: _attributes.height,
      fit: FloraAnimationStyle.resolveFit(_attributes.fit),
      repeat: _attributes.repeat,
      reverse: _attributes.reverse,
      animate: _attributes.animate,
      onLoaded: _attributes.onLoaded != null ? (_) => _attributes.onLoaded!() : null,
    );

    if (_attributes.semanticLabel == null) return animation;
    return Semantics(label: _attributes.semanticLabel, child: animation);
  }
}
