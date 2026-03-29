/// Flora DS — Progress Step Component
library;

import 'package:flutter/material.dart';
import 'package:flora/components/progress/step/flora_progress_step_attributes.dart';
import 'package:flora/components/progress/step/flora_progress_step_style.dart';

export 'flora_progress_step_attributes.dart';
export 'flora_progress_step_style.dart';

class FloraProgressStep extends StatelessWidget {
  FloraProgressStep({
    super.key,
    required int totalSteps,
    required int completedSteps,
    FloraProgressStepVariant variant = FloraProgressStepVariant.primary,
    bool showLabel = false,
    double height = FloraProgressStepStyle.defaultHeight,
    double spacing = FloraProgressStepStyle.defaultSpacing,
  }) : _attributes = FloraProgressStepAttributes(
         totalSteps: totalSteps,
         completedSteps: completedSteps,
         variant: variant,
         showLabel: showLabel,
         height: height,
         spacing: spacing,
       );

  final FloraProgressStepAttributes _attributes;

  Widget _buildBar(BuildContext context) {
    final active = FloraProgressStepStyle.activeColor(context, _attributes.variant);
    final track = FloraProgressStepStyle.trackColor(context);
    final radius = BorderRadius.circular(_attributes.height / 2);

    final segments = List.generate(_attributes.totalSteps, (i) {
      return Expanded(
        child: Container(
          height: _attributes.height,
          decoration: BoxDecoration(
            color: i < _attributes.completedSteps ? active : track,
            borderRadius: radius,
          ),
        ),
      );
    });

    return Row(
      children: segments
          .expand((s) => [s, SizedBox(width: _attributes.spacing)])
          .toList()
        ..removeLast(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bar = _buildBar(context);

    if (!_attributes.showLabel) return bar;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            'Step ${_attributes.completedSteps} of ${_attributes.totalSteps}',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        bar,
      ],
    );
  }
}
