import 'package:flora/flora.dart';
import 'package:flora_sample/sample_section.dart';
import 'package:flutter/material.dart';

class FloraIconButtonSample extends StatelessWidget {
  const FloraIconButtonSample({super.key});

  @override
  Widget build(BuildContext context) {
    return SampleScaffold(
      title: 'Icon Button',
      children: [
        SampleSection(
          title: 'Variants',
          children: [
            Wrap(
              spacing: FloraSpacing.s3,
              children: [
                for (final variant in FloraIconButtonVariant.values)
                  Column(
                    children: [
                      FloraIconButton(
                        icon: const Icon(Icons.favorite_border),
                        variant: variant,
                        onPressed: () {},
                      ),
                      const SizedBox(height: FloraSpacing.s2),
                      Text(variant.name, style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
              ],
            ),
          ],
        ),
        SampleSection(
          title: 'Selected State',
          children: [
            Wrap(
              spacing: FloraSpacing.s3,
              children: [
                for (final variant in FloraIconButtonVariant.values)
                  Column(
                    children: [
                      FloraIconButton(
                        icon: const Icon(Icons.favorite_border),
                        selectedIcon: const Icon(Icons.favorite),
                        variant: variant,
                        isSelected: true,
                        onPressed: () {},
                      ),
                      const SizedBox(height: FloraSpacing.s2),
                      Text(variant.name, style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
              ],
            ),
          ],
        ),
        SampleSection(
          title: 'Disabled',
          children: [
            FloraIconButton(
              icon: const Icon(Icons.favorite_border),
              variant: FloraIconButtonVariant.filled,
              onPressed: null,
            ),
          ],
        ),
      ],
    );
  }
}