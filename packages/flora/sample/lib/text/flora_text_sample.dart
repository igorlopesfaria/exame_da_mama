import 'package:flora/flora.dart';
import 'package:flora_sample/sample_section.dart';
import 'package:flutter/material.dart';

class FloraTextSample extends StatelessWidget {
  const FloraTextSample({super.key});

  @override
  Widget build(BuildContext context) {
    return SampleScaffold(
      title: 'Text',
      children: [
        SampleSection(
          title: 'Display',
          children: [
            FloraText.displayLarge('Display Large'),
            FloraText.displayMedium('Display Medium'),
            FloraText.displaySmall('Display Small'),
          ],
        ),
        SampleSection(
          title: 'Headline',
          children: [
            FloraText.headlineLarge('Headline Large'),
            FloraText.headlineMedium('Headline Medium'),
            FloraText.headlineSmall('Headline Small'),
          ],
        ),
        SampleSection(
          title: 'Title',
          children: [
            FloraText.titleLarge('Title Large'),
            FloraText.titleMedium('Title Medium'),
            FloraText.titleSmall('Title Small'),
          ],
        ),
        SampleSection(
          title: 'Label',
          children: [
            FloraText.labelLarge('Label Large'),
            FloraText.labelMedium('Label Medium'),
            FloraText.labelSmall('Label Small'),
          ],
        ),
        SampleSection(
          title: 'Body',
          children: [
            FloraText.bodyLarge('Body Large — The quick brown fox jumps over the lazy dog'),
            FloraText.bodyMedium('Body Medium — The quick brown fox jumps over the lazy dog'),
            FloraText.bodySmall('Body Small — The quick brown fox jumps over the lazy dog'),
          ],
        ),
        SampleSection(
          title: 'Colors',
          children: [
            for (final color in FloraTextColor.values)
              FloraText('Color: ${color.name}', color: color),
          ],
        ),
      ],
    );
  }
}