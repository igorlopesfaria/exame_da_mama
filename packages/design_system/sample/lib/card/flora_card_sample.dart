import 'package:flora/flora.dart';
import 'package:flora_sample/sample_section.dart';
import 'package:flutter/material.dart';

class FloraCardSample extends StatelessWidget {
  const FloraCardSample({super.key});

  Widget _cardContent(String label) => Padding(
        padding: const EdgeInsets.all(FloraSpacing.s4),
        child: Text(label),
      );

  @override
  Widget build(BuildContext context) {
    return SampleScaffold(
      title: 'Card',
      children: [
        SampleSection(
          title: 'Variants',
          children: [
            for (final variant in FloraCardVariant.values)
              Padding(
                padding: const EdgeInsets.only(bottom: FloraSpacing.s3),
                child: FloraCard(
                  variant: variant,
                  child: _cardContent(variant.name),
                ),
              ),
          ],
        ),
        SampleSection(
          title: 'Tappable',
          children: [
            FloraCard(
              onTap: () {},
              child: _cardContent('Tap me'),
            ),
            const SizedBox(height: FloraSpacing.s3),
            FloraCard(
              onTap: () {},
              onLongPress: () {},
              child: _cardContent('Tap or long press'),
            ),
          ],
        ),
        SampleSection(
          title: 'Custom padding & margin',
          children: [
            FloraCard(
              padding: const EdgeInsets.all(FloraSpacing.s6),
              margin: const EdgeInsets.symmetric(horizontal: FloraSpacing.s4),
              child: _cardContent('Custom spacing'),
            ),
          ],
        ),
      ],
    );
  }
}