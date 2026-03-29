import 'package:flora/flora.dart';
import 'package:flora_sample/sample_section.dart';
import 'package:flutter/material.dart';

class FloraToastSample extends StatelessWidget {
  const FloraToastSample({super.key});

  @override
  Widget build(BuildContext context) {
    return SampleScaffold(
      title: 'Toast',
      children: [
        SampleSection(
          title: 'Variants',
          children: [
            for (final variant in FloraToastVariant.values)
              Padding(
                padding: const EdgeInsets.only(bottom: FloraSpacing.s3),
                child: FloraButton(
                  label: variant.name,
                  variant: FloraButtonVariant.outlined,
                  onPressed: () => FloraToast.show(
                    context,
                    message: '${variant.name} toast message',
                    variant: variant,
                  ),
                ),
              ),
          ],
        ),
        SampleSection(
          title: 'With action',
          children: [
            FloraButton(
              label: 'Show with action',
              onPressed: () => FloraToast.show(
                context,
                message: 'Item deleted',
                variant: FloraToastVariant.info,
                actionLabel: 'Undo',
                onAction: () {},
              ),
            ),
          ],
        ),
        SampleSection(
          title: 'With close button',
          children: [
            FloraButton(
              label: 'Show with close',
              onPressed: () => FloraToast.show(
                context,
                message: 'Dismiss me',
                variant: FloraToastVariant.success,
                showCloseButton: true,
                duration: FloraToastDuration.persistent,
              ),
            ),
          ],
        ),
        SampleSection(
          title: 'Position',
          children: [
            FloraButton(
              label: 'Bottom (default)',
              onPressed: () => FloraToast.show(
                context,
                message: 'Showing at bottom',
                position: FloraToastPosition.bottom,
              ),
            ),
            const SizedBox(height: FloraSpacing.s3),
            FloraButton(
              label: 'Top',
              onPressed: () => FloraToast.show(
                context,
                message: 'Showing at top',
                position: FloraToastPosition.top,
              ),
            ),
          ],
        ),
      ],
    );
  }
}