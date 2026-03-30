import 'package:flora/flora.dart';
import 'package:flora_sample/sample_section.dart';
import 'package:flutter/material.dart';

class FloraImageSample extends StatelessWidget {
  const FloraImageSample({super.key});

  static const _networkUrl =
      'https://picsum.photos/seed/flora/600/400';

  @override
  Widget build(BuildContext context) {
    return SampleScaffold(
      title: 'Image',
      children: [
        SampleSection(
          title: 'Network',
          children: [
            FloraImage.network(
              _networkUrl,
              width: double.infinity,
              height: 180,
            ),
          ],
        ),
        SampleSection(
          title: 'Network — Border Radius',
          children: [
            FloraImage.network(
              _networkUrl,
              width: double.infinity,
              height: 180,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
          ],
        ),
        SampleSection(
          title: 'Network — Custom Placeholder & Error',
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FloraText.labelSmall('Placeholder'),
                      const SizedBox(height: FloraSpacing.s2),
                      FloraImage.network(
                        'https://picsum.photos/seed/placeholder/300/200',
                        height: 100,
                        placeholder: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: FloraSpacing.s3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FloraText.labelSmall('Error widget'),
                      const SizedBox(height: FloraSpacing.s2),
                      FloraImage.network(
                        'https://invalid.url/broken.jpg',
                        height: 100,
                        errorWidget: Container(
                          color: Theme.of(context).colorScheme.errorContainer,
                          child: Center(
                            child: Icon(
                              Icons.broken_image_outlined,
                              color: Theme.of(context).colorScheme.onErrorContainer,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        SampleSection(
          title: 'Fit Variants',
          children: [
            for (final fit in FloraImageFit.values) ...[
              FloraText.labelSmall(fit.name),
              const SizedBox(height: FloraSpacing.s2),
              Container(
                width: double.infinity,
                height: 100,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: FloraImage.network(
                  'https://picsum.photos/seed/${fit.name}/400/200',
                  fit: fit,
                ),
              ),
              const SizedBox(height: FloraSpacing.s3),
            ],
          ],
        ),
        SampleSection(
          title: 'Asset (PNG from flora package)',
          children: [
            FloraImage.asset(
              FloraImageAssets.sampleImage,
              width: double.infinity,
              height: 160,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
          ],
        ),
      ],
    );
  }
}
