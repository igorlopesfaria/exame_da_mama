/// Flora DS Media — FloraImage Component
library;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'flora_image_attributes.dart';
import 'flora_image_style.dart';

class FloraImage extends StatelessWidget {
  FloraImage.asset(
    String path, {
    super.key,
    double? width,
    double? height,
    FloraImageFit fit = FloraImageFit.cover,
    BorderRadiusGeometry? borderRadius,
    Widget? errorWidget,
    String? semanticLabel,
  }) : _attributes = FloraImageAttributes(
         source: path,
         variant: FloraImageVariant.asset,
         width: width,
         height: height,
         fit: fit,
         borderRadius: borderRadius,
         errorWidget: errorWidget,
         semanticLabel: semanticLabel,
       );

  FloraImage.network(
    String url, {
    super.key,
    double? width,
    double? height,
    FloraImageFit fit = FloraImageFit.cover,
    BorderRadiusGeometry? borderRadius,
    Widget? placeholder,
    Widget? errorWidget,
    String? semanticLabel,
  }) : _attributes = FloraImageAttributes(
         source: url,
         variant: FloraImageVariant.network,
         width: width,
         height: height,
         fit: fit,
         borderRadius: borderRadius,
         placeholder: placeholder,
         errorWidget: errorWidget,
         semanticLabel: semanticLabel,
       );

  final FloraImageAttributes _attributes;

  Widget _buildImage(BuildContext context) {
    final boxFit = FloraImageStyle.resolveFit(_attributes.fit);
    return switch (_attributes.variant) {
      FloraImageVariant.asset => Image.asset(
          _attributes.source,
          width: _attributes.width,
          height: _attributes.height,
          fit: boxFit,
          semanticLabel: _attributes.semanticLabel,
          errorBuilder: (context, _, __) =>
              _attributes.errorWidget ?? FloraImageStyle.defaultErrorWidget(context),
        ),
      FloraImageVariant.network => CachedNetworkImage(
          imageUrl: _attributes.source,
          width: _attributes.width,
          height: _attributes.height,
          fit: boxFit,
          placeholder: (context, _) =>
              _attributes.placeholder ?? FloraImageStyle.defaultPlaceholder(context),
          errorWidget: (context, _, __) =>
              _attributes.errorWidget ?? FloraImageStyle.defaultErrorWidget(context),
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final image = _buildImage(context);
    if (_attributes.borderRadius == null) return image;
    return ClipRRect(borderRadius: _attributes.borderRadius!, child: image);
  }
}
