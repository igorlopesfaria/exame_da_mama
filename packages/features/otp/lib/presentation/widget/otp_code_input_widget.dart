import 'package:flora/flora.dart';
import 'package:flutter/material.dart';

class OtpCodeInputWidget extends StatelessWidget {
  const OtpCodeInputWidget({
    super.key,
    required this.onChanged,
    this.errorText,
  });

  final void Function(String code) onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return FloraTextInputCode(
      length: 5,
      variant: FloraTextInputCodeVariant.outlined,
      onChanged: onChanged,
      errorText: errorText,
    );
  }
}
