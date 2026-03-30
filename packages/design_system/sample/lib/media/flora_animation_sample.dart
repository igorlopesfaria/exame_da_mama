import 'package:flora/flora.dart';
import 'package:flora_sample/sample_section.dart';
import 'package:flutter/material.dart';

class FloraAnimationSample extends StatelessWidget {
  const FloraAnimationSample({super.key});

  static const _asset = FloraAnimationAssets.sampleAnimation;

  @override
  Widget build(BuildContext context) {
    return SampleScaffold(
      title: 'Animation',
      children: [
        SampleSection(
          title: 'Default (repeat)',
          children: [
            Center(
              child: FloraAnimation.asset(_asset, width: 160, height: 160),
            ),
          ],
        ),
        SampleSection(
          title: 'Paused',
          children: [
            Center(
              child: FloraAnimation.asset(
                _asset,
                width: 160,
                height: 160,
                animate: false,
              ),
            ),
          ],
        ),
        SampleSection(
          title: 'Single play (no repeat)',
          children: [
            Center(
              child: FloraAnimation.asset(
                _asset,
                width: 160,
                height: 160,
                repeat: false,
              ),
            ),
          ],
        ),
        SampleSection(
          title: 'Reversed',
          children: [
            Center(
              child: FloraAnimation.asset(
                _asset,
                width: 160,
                height: 160,
                reverse: true,
              ),
            ),
          ],
        ),
        SampleSection(
          title: 'Fit Variants',
          children: [
            for (final fit in FloraAnimationFit.values) ...[
              FloraText.labelSmall(fit.name),
              const SizedBox(height: FloraSpacing.s2),
              Container(
                width: double.infinity,
                height: 100,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: FloraAnimation.asset(_asset, fit: fit),
              ),
              const SizedBox(height: FloraSpacing.s3),
            ],
          ],
        ),
        SampleSection(
          title: 'With onLoaded callback',
          children: [
            _AnimationWithCallback(asset: _asset),
          ],
        ),
      ],
    );
  }
}

class _AnimationWithCallback extends StatefulWidget {
  const _AnimationWithCallback({required this.asset});
  final String asset;

  @override
  State<_AnimationWithCallback> createState() => _AnimationWithCallbackState();
}

class _AnimationWithCallbackState extends State<_AnimationWithCallback> {
  bool _loaded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: FloraAnimation.asset(
            widget.asset,
            width: 120,
            height: 120,
            onLoaded: () => setState(() => _loaded = true),
          ),
        ),
        const SizedBox(height: FloraSpacing.s3),
        FloraText(
          _loaded ? 'onLoaded fired' : 'Loading...',
          color: _loaded ? FloraTextColor.success : FloraTextColor.secondary,
        ),
      ],
    );
  }
}
