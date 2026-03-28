/// Flora DS — Chip Group Attributes
library;

import 'package:flutter/widgets.dart';

class FloraChipGroupAttributes {
  const FloraChipGroupAttributes({
    required this.chips,
    this.spacing = 8,
    this.padding,
  });

  final List<Widget> chips;
  final double spacing;
  final EdgeInsetsGeometry? padding;
}