import 'package:flora/flora.dart';
import 'package:flora_sample/sample_section.dart';
import 'package:flutter/material.dart';

class FloraButtonSample extends StatelessWidget {
  const FloraButtonSample({super.key});

  @override
  Widget build(BuildContext context) {
    return SampleScaffold(
      title: 'Button',
      children: [
        SampleSection(
          title: 'Variants',
          children: [
            for (final variant in FloraButtonVariant.values)
              Padding(
                padding: const EdgeInsets.only(bottom: FloraSpacing.s3),
                child: FloraButton(
                  label: variant.name,
                  variant: variant,
                  onPressed: () {},
                ),
              ),
          ],
        ),
        SampleSection(
          title: 'Sizes',
          children: [
            for (final size in FloraButtonSize.values)
              Padding(
                padding: const EdgeInsets.only(bottom: FloraSpacing.s3),
                child: FloraButton(
                  label: size.name,
                  size: size,
                  onPressed: () {},
                ),
              ),
          ],
        ),
        SampleSection(
          title: 'With Icons',
          children: [
            FloraButton(
              label: 'Leading icon',
              leadingIcon: const Icon(Icons.add),
              onPressed: () {},
            ),
            const SizedBox(height: FloraSpacing.s3),
            FloraButton(
              label: 'Trailing icon',
              trailingIcon: const Icon(Icons.arrow_forward),
              onPressed: () {},
            ),
          ],
        ),
        SampleSection(
          title: 'States',
          children: [
            FloraButton(label: 'Loading', isLoading: true, onPressed: () {}),
            const SizedBox(height: FloraSpacing.s3),
            FloraButton(label: 'Disabled', onPressed: null),
          ],
        ),
      ],
    );
  }
}
