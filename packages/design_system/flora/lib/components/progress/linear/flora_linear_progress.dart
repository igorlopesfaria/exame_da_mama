/// Flora DS — Linear Progress Component
library;

import 'package:flutter/material.dart';
import 'package:flora/components/progress/linear/flora_linear_progress_attributes.dart';
import 'package:flora/components/progress/linear/flora_linear_progress_style.dart';

export 'flora_linear_progress_attributes.dart';
export 'flora_linear_progress_style.dart';

class FloraLinearProgress extends StatelessWidget {
  FloraLinearProgress({
    super.key,
    double? value,
    String? label,
    bool showPercentage = false,
    double minHeight = 4,
  }) : _attributes = FloraLinearProgressAttributes(
         value: value,
         label: label,
         showPercentage: showPercentage,
         minHeight: minHeight,
       );

  final FloraLinearProgressAttributes _attributes;

  @override
  Widget build(BuildContext context) {
    final bar = LinearProgressIndicator(
      value: _attributes.value,
      minHeight: _attributes.minHeight,
      borderRadius: BorderRadius.circular(_attributes.minHeight / 2),
      color: FloraLinearProgressStyle.indicatorColor(context),
      backgroundColor: FloraLinearProgressStyle.trackColor(context),
    );
    if (_attributes.label == null && !_attributes.showPercentage) return bar;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_attributes.label != null)
                Text(_attributes.label!, style: Theme.of(context).textTheme.bodyMedium),
              if (_attributes.showPercentage && _attributes.value != null)
                Text(
                  '${(_attributes.value! * 100).round()}%',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
            ],
          ),
        ),
        bar,
      ],
    );
  }
}