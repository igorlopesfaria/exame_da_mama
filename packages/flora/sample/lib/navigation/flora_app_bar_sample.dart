import 'package:flora/flora.dart';
import 'package:flora_sample/sample_section.dart';
import 'package:flutter/material.dart';

class FloraAppBarSample extends StatelessWidget {
  const FloraAppBarSample({super.key});

  @override
  Widget build(BuildContext context) {
    return SampleScaffold(
      title: 'App Bar',
      children: [
        SampleSection(
          title: 'Small (default)',
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: kToolbarHeight,
                child: FloraAppBar(
                  title: const Text('Small App Bar'),
                  automaticallyImplyLeading: false,
                  actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
                ),
              ),
            ),
          ],
        ),
        SampleSection(
          title: 'Medium',
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 112,
                child: FloraAppBar(
                  variant: FloraAppBarVariant.medium,
                  title: const Text('Medium App Bar'),
                  automaticallyImplyLeading: false,
                  actions: [IconButton(icon: const Icon(Icons.more_vert), onPressed: () {})],
                ),
              ),
            ),
          ],
        ),
        SampleSection(
          title: 'Large',
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 152,
                child: FloraAppBar(
                  variant: FloraAppBarVariant.large,
                  title: const Text('Large App Bar'),
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(icon: const Icon(Icons.share), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
                  ],
                ),
              ),
            ),
          ],
        ),
        SampleSection(
          title: 'With leading back button',
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: kToolbarHeight,
                child: FloraAppBar(
                  title: const Text('Detail Screen'),
                  leading: const Icon(Icons.arrow_back),
                  actions: [IconButton(icon: const Icon(Icons.edit), onPressed: () {})],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
