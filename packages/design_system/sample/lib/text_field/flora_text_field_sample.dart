import 'package:flora/flora.dart';
import 'package:flora_sample/sample_section.dart';
import 'package:flutter/material.dart';

class FloraTextFieldSample extends StatelessWidget {
  const FloraTextFieldSample({super.key});

  @override
  Widget build(BuildContext context) {
    return SampleScaffold(
      title: 'Text Field',
      children: [
        SampleSection(
          title: 'Variants',
          children: [
            FloraTextField(label: 'Filled', variant: FloraTextFieldVariant.filled),
            const SizedBox(height: FloraSpacing.s4),
            FloraTextField(label: 'Outlined', variant: FloraTextFieldVariant.outlined),
          ],
        ),
        SampleSection(
          title: 'With Support Text',
          children: [
            FloraTextField(label: 'With hint', hint: 'Type something...'),
            const SizedBox(height: FloraSpacing.s4),
            FloraTextField(label: 'With helper', helperText: 'This is a helper text'),
            const SizedBox(height: FloraSpacing.s4),
            FloraTextField(label: 'With error', errorText: 'This field is required'),
          ],
        ),
        SampleSection(
          title: 'With Icons',
          children: [
            FloraTextField(label: 'Search', prefixIcon: const Icon(Icons.search)),
            const SizedBox(height: FloraSpacing.s4),
            FloraTextField(
              label: 'Password',
              obscureText: true,
              suffixIcon: const Icon(Icons.visibility_off_outlined),
            ),
          ],
        ),
        SampleSection(
          title: 'States',
          children: [
            FloraTextField(label: 'Disabled', enabled: false),
            const SizedBox(height: FloraSpacing.s4),
            FloraTextField(label: 'Read only', readOnly: true),
          ],
        ),
      ],
    );
  }
}