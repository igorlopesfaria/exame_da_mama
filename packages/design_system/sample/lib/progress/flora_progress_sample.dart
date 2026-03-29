import 'package:flora/flora.dart';
import 'package:flora_sample/sample_section.dart';
import 'package:flutter/material.dart';

class FloraProgressSample extends StatefulWidget {
  const FloraProgressSample({super.key});

  @override
  State<FloraProgressSample> createState() => _FloraProgressSampleState();
}

class _FloraProgressSampleState extends State<FloraProgressSample> {
  int _currentStep = 2;
  static const int _totalSteps = 5;

  @override
  Widget build(BuildContext context) {
    return SampleScaffold(
      title: 'Progress',
      children: [
        SampleSection(
          title: 'Linear — Indeterminate',
          children: [
            FloraLinearProgress(),
            const SizedBox(height: FloraSpacing.s3),
            FloraLinearProgress(minHeight: 8),
          ],
        ),
        SampleSection(
          title: 'Linear — Determinate',
          children: [
            FloraLinearProgress(value: 0.3, label: 'Uploading...'),
            const SizedBox(height: FloraSpacing.s4),
            FloraLinearProgress(value: 0.7, label: 'Processing', showPercentage: true),
            const SizedBox(height: FloraSpacing.s4),
            FloraLinearProgress(value: 1.0, showPercentage: true),
          ],
        ),
        SampleSection(
          title: 'Circular — Indeterminate',
          children: [
            Wrap(
              spacing: FloraSpacing.s6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                for (final size in FloraProgressSize.values)
                  Column(
                    children: [
                      FloraCircularProgress(size: size),
                      const SizedBox(height: FloraSpacing.s2),
                      Text(size.name, style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
              ],
            ),
          ],
        ),
        SampleSection(
          title: 'Circular — Determinate',
          children: [
            Wrap(
              spacing: FloraSpacing.s6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                for (final entry in {
                  FloraProgressSize.small: 0.3,
                  FloraProgressSize.medium: 0.6,
                  FloraProgressSize.large: 0.9,
                }.entries)
                  FloraCircularProgress(value: entry.value, size: entry.key),
              ],
            ),
          ],
        ),
        SampleSection(
          title: 'Shimmer',
          children: [
            const FloraShimmerListItem(),
            const FloraShimmerListItem(),
            const FloraShimmerListItem(hasLeading: false),
          ],
        ),
        SampleSection(
          title: 'Step — Interactive',
          children: [
            FloraProgressStep(
              totalSteps: _totalSteps,
              completedSteps: _currentStep,
              showLabel: true,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton.tonal(
                  onPressed: _currentStep > 0
                      ? () => setState(() => _currentStep--)
                      : null,
                  child: const Text('Back'),
                ),
                const SizedBox(width: 16),
                FilledButton(
                  onPressed: _currentStep < _totalSteps
                      ? () => setState(() => _currentStep++)
                      : null,
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
        SampleSection(
          title: 'Step — Variants',
          children: [
            for (final variant in FloraProgressStepVariant.values) ...[
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      variant.name,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FloraProgressStep(
                      totalSteps: 5,
                      completedSteps: 3,
                      variant: variant,
                      height: 6,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
        SampleSection(
          title: 'Step — States',
          children: [
            _StepRow(label: 'None done', totalSteps: 5, completedSteps: 0),
            const SizedBox(height: 12),
            _StepRow(label: 'Partial', totalSteps: 5, completedSteps: 3),
            const SizedBox(height: 12),
            _StepRow(label: 'All done', totalSteps: 5, completedSteps: 5),
          ],
        ),
      ],
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.label,
    required this.totalSteps,
    required this.completedSteps,
  });

  final String label;
  final int totalSteps;
  final int completedSteps;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      SizedBox(
        width: 80,
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
      Expanded(
        child: FloraProgressStep(
          totalSteps: totalSteps,
          completedSteps: completedSteps,
        ),
      ),
    ],
  );
}
