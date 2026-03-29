import 'package:flora/flora.dart';
import 'package:flora_sample/sample_section.dart';
import 'package:flutter/material.dart';

class FloraFABSample extends StatelessWidget {
  const FloraFABSample({super.key});

  @override
  Widget build(BuildContext context) {
    return SampleScaffold(
      title: 'FAB',
      children: [
        SampleSection(
          title: 'Sizes',
          children: [
            Wrap(
              spacing: FloraSpacing.s4,
              runSpacing: FloraSpacing.s4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                for (final size in FloraFABSize.values)
                  Column(
                    children: [
                      FloraFAB(icon: const Icon(Icons.add), size: size, onPressed: () {}),
                      const SizedBox(height: FloraSpacing.s2),
                      Text(size.name, style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
              ],
            ),
          ],
        ),
        SampleSection(
          title: 'Extended (with label)',
          children: [
            for (final size in FloraFABSize.values)
              Padding(
                padding: const EdgeInsets.only(bottom: FloraSpacing.s3),
                child: Row(
                  children: [
                    FloraFAB(
                      icon: const Icon(Icons.add),
                      label: size.name,
                      size: size,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}