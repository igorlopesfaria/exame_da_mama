import 'package:flora/flora.dart';
import 'package:flora_sample/sample_section.dart';
import 'package:flutter/material.dart';

class FloraBottomSheetSample extends StatelessWidget {
  const FloraBottomSheetSample({super.key});

  @override
  Widget build(BuildContext context) {
    return SampleScaffold(
      title: 'Bottom Sheet',
      children: [
        SampleSection(
          title: 'Basic',
          children: [
            FloraButton(
              label: 'Show basic bottom sheet',
              onPressed: () => FloraBottomSheet.show(
                context,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Bottom Sheet Title',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: FloraSpacing.s3),
                    Text(
                      'This is a basic bottom sheet with a drag indicator at the top. Drag it down or tap outside to dismiss.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: FloraSpacing.s4),
                    FloraButton(
                      label: 'Got it',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SampleSection(
          title: 'Non-dismissible',
          children: [
            FloraButton(
              label: 'Show non-dismissible',
              variant: FloraButtonVariant.outlined,
              onPressed: () => FloraBottomSheet.show(
                context,
                isDismissible: false,
                enableDrag: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Action Required',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: FloraSpacing.s3),
                    Text(
                      'This sheet cannot be dismissed by tapping outside or dragging. Use the action below.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: FloraSpacing.s4),
                    FloraButton(
                      label: 'Confirm',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SampleSection(
          title: 'Scrollable content',
          children: [
            FloraButton(
              label: 'Show scrollable content',
              variant: FloraButtonVariant.tonal,
              onPressed: () => FloraBottomSheet.show(
                context,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Long Content',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: FloraSpacing.s3),
                    for (int i = 1; i <= 8; i++) ...[
                      FloraListTile(
                        title: Text('Item $i'),
                        subtitle: Text('Description for item $i'),
                        onTap: () {},
                      ),
                      if (i < 8) const Divider(height: 1),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
