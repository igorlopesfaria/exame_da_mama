import 'package:flora/flora.dart';
import 'package:flora_sample/sample_section.dart';
import 'package:flutter/material.dart';

class FloraIconSample extends StatelessWidget {
  const FloraIconSample({super.key});

  static const _previewIcons = [
    Icons.favorite_outline,
    Icons.star_outline,
    Icons.home_outlined,
    Icons.person_outline,
    Icons.settings_outlined,
    Icons.notifications_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return SampleScaffold(
      title: 'Icon',
      children: [
        SampleSection(
          title: 'Flutter Icons',
          children: [
            Wrap(
              spacing: FloraSpacing.s4,
              runSpacing: FloraSpacing.s4,
              children: [
                for (final icon in _previewIcons)
                  FloraIcon.flutter(icon),
              ],
            ),
          ],
        ),
        SampleSection(
          title: 'Colors',
          children: [
            Wrap(
              spacing: FloraSpacing.s4,
              runSpacing: FloraSpacing.s4,
              children: [
                for (final color in FloraIconColor.values)
                  Column(
                    children: [
                      FloraIcon.flutter(Icons.circle, color: color, size: 32),
                      const SizedBox(height: FloraSpacing.s1),
                      FloraText.labelSmall(color.name),
                    ],
                  ),
              ],
            ),
          ],
        ),
        SampleSection(
          title: 'Sizes',
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final size in [16.0, 24.0, 32.0, 40.0, 48.0]) ...[
                  Column(
                    children: [
                      FloraIcon.flutter(Icons.favorite, size: size),
                      const SizedBox(height: FloraSpacing.s2),
                      FloraText.labelSmall('${size.toInt()}'),
                    ],
                  ),
                  const SizedBox(width: FloraSpacing.s4),
                ],
              ],
            ),
          ],
        ),
        SampleSection(
          title: 'Asset (PNG from flora package)',
          children: [
            Wrap(
              spacing: FloraSpacing.s4,
              runSpacing: FloraSpacing.s4,
              children: [
                for (final color in FloraIconColor.values)
                  Column(
                    children: [
                      FloraIcon.asset(
                        FloraIconAssets.sampleIcon,
                        size: 40,
                        color: color,
                      ),
                      const SizedBox(height: FloraSpacing.s1),
                      FloraText.labelSmall(color.name),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
