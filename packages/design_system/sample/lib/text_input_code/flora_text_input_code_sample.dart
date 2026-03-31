import 'package:flora/flora.dart';
import 'package:flora_sample/sample_section.dart';
import 'package:flutter/material.dart';

class FloraTextInputCodeSample extends StatelessWidget {
  const FloraTextInputCodeSample({super.key});

  @override
  Widget build(BuildContext context) {
    return SampleScaffold(
      title: 'Text Input Code',
      children: [
        SampleSection(
          title: '4-digit code (outlined)',
          children: [
            FloraTextInputCode(
              length: 4,
              variant: FloraTextInputCodeVariant.outlined,
              onCompleted: (code) => debugPrint('Completed: $code'),
            ),
          ],
        ),
        SampleSection(
          title: '6-digit code filled (with error)',
          children: [
            FloraTextInputCode(
              length: 6,
              variant: FloraTextInputCodeVariant.filled,
              errorText: 'Invalid code',
            ),
          ],
        ),
        SampleSection(
          title: '4-digit PIN outlined (obscured)',
          children: [
            FloraTextInputCode(
              length: 4,
              variant: FloraTextInputCodeVariant.outlined,
              obscureText: true,
              onCompleted: (code) => debugPrint('PIN: $code'),
            ),
          ],
        ),
        SampleSection(
          title: '4-digit PIN filled (obscured)',
          children: [
            FloraTextInputCode(
              length: 4,
              variant: FloraTextInputCodeVariant.filled,
              obscureText: true,
              onCompleted: (code) => debugPrint('PIN: $code'),
            ),
          ],
        ),
      ],
    );
  }
}
