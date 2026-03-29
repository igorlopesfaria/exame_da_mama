/// Flora DS — Linear Progress Style
library;

import 'package:flutter/material.dart';

abstract final class FloraLinearProgressStyle {
  static Color trackColor(BuildContext context) => Theme.of(context).colorScheme.secondaryContainer;
  static Color indicatorColor(BuildContext context) => Theme.of(context).colorScheme.primary;
}