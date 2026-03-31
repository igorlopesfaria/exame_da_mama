/// Flora DS — Circular Progress Attributes
library;

enum FloraProgressSize { small, medium, large }

class FloraCircularProgressAttributes {
  const FloraCircularProgressAttributes({
    this.value,
    this.size = FloraProgressSize.medium,
  });

  final double? value;
  final FloraProgressSize size;
}
