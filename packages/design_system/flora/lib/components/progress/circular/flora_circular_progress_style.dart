/// Flora DS — Circular Progress Style
library;

import 'package:flutter/material.dart';
import 'package:flora/components/progress/circular/flora_circular_progress_attributes.dart';

abstract final class FloraCircularProgressStyle {
  static double circularSize(FloraProgressSize size) => switch (size) {
    FloraProgressSize.small  => 20,
    FloraProgressSize.medium => 40,
    FloraProgressSize.large  => 48,
  };

  static double strokeWidth(FloraProgressSize size) => switch (size) {
    FloraProgressSize.small  => 2.5,
    FloraProgressSize.medium => 4,
    FloraProgressSize.large  => 4,
  };

  static Color trackColor(BuildContext context) => Theme.of(context).colorScheme.secondaryContainer;
  static Color indicatorColor(BuildContext context) => Theme.of(context).colorScheme.primary;
}