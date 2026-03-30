/// Flora DS — Circular Progress Component
library;

import 'package:flutter/material.dart';
import 'package:flora/components/progress/circular/flora_circular_progress_attributes.dart';
import 'package:flora/components/progress/circular/flora_circular_progress_style.dart';

export 'flora_circular_progress_attributes.dart';
export 'flora_circular_progress_style.dart';

class FloraCircularProgress extends StatelessWidget {
  FloraCircularProgress({
    super.key,
    double? value,
    FloraProgressSize size = FloraProgressSize.medium,
  }) : _attributes = FloraCircularProgressAttributes(
         value: value,
         size: size,
       );

  final FloraCircularProgressAttributes _attributes;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: FloraCircularProgressStyle.circularSize(_attributes.size),
    child: CircularProgressIndicator(
      value: _attributes.value,
      strokeWidth: FloraCircularProgressStyle.strokeWidth(_attributes.size),
      strokeCap: StrokeCap.round,
      color: FloraCircularProgressStyle.indicatorColor(context),
      backgroundColor: FloraCircularProgressStyle.trackColor(context),
    ),
  );
}