/// Flora DS — Progress Step Attributes
library;

enum FloraProgressStepVariant { primary, secondary, success, error }

class FloraProgressStepAttributes {
  const FloraProgressStepAttributes({
    required this.totalSteps,
    required this.completedSteps,
    this.variant = FloraProgressStepVariant.primary,
    this.showLabel = false,
    this.height = 4.0,
    this.spacing = 4.0,
  }) : assert(totalSteps > 0, 'totalSteps must be greater than 0'),
       assert(completedSteps >= 0 && completedSteps <= totalSteps,
           'completedSteps must be between 0 and totalSteps');

  final int totalSteps;
  final int completedSteps;
  final FloraProgressStepVariant variant;
  final bool showLabel;
  final double height;
  final double spacing;
}
