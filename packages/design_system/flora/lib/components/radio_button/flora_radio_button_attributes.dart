/// Flora DS — Radio Button Attributes
library;

class FloraRadioButtonAttributes<T> {
  const FloraRadioButtonAttributes({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.toggleable = false,
    this.enabled = true,
  });

  final T value;
  final T? groupValue;
  final void Function(T?)? onChanged;
  final String? label;
  final bool toggleable;
  final bool enabled;
}