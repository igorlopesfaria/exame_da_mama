/// Flora DS — Linear Progress Attributes
library;

class FloraLinearProgressAttributes {
  const FloraLinearProgressAttributes({
    this.value,
    this.label,
    this.showPercentage = false,
    this.minHeight = 4,
  });

  final double? value;
  final String? label;
  final bool showPercentage;
  final double minHeight;
}