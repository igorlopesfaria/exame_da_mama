/// Flora DS — Chip Group Component
library;

import 'package:flutter/widgets.dart';
import 'package:flora/components/chips/group/flora_chip_group_attributes.dart';
import 'package:flora/components/chips/group/flora_chip_group_style.dart';

class FloraChipGroup extends StatelessWidget {
  FloraChipGroup({
    super.key,
    required List<Widget> chips,
    double spacing = FloraChipGroupStyle.defaultSpacing,
    EdgeInsetsGeometry? padding,
  }) : _attributes = FloraChipGroupAttributes(
          chips: chips,
          spacing: spacing,
          padding: padding,
        );

  final FloraChipGroupAttributes _attributes;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: _attributes.padding ?? FloraChipGroupStyle.defaultPadding,
        child: Row(
          children: _attributes.chips
              .expand((c) => [c, SizedBox(width: _attributes.spacing)])
              .toList()
            ..removeLast(),
        ),
      );
}