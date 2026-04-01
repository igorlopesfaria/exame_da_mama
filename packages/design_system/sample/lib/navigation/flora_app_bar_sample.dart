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
                  title: 'Small App Bar',
                  automaticallyImplyLeading: false,
                  actions: [
                    FloraAppBarAction(
                      flutterIcon: Icons.search,
                      onPressed: () {},
                      tooltip: 'Search',
                    ),
                  ],
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
                  title: 'Medium App Bar',
                  automaticallyImplyLeading: false,
                  actions: [
                    FloraAppBarAction(
                      flutterIcon: Icons.more_vert,
                      onPressed: () {},
                      tooltip: 'More options',
                    ),
                  ],
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
                  title: 'Large App Bar',
                  automaticallyImplyLeading: false,
                  actions: [
                    FloraAppBarAction(
                      flutterIcon: Icons.share,
                      onPressed: () {},
                      tooltip: 'Share',
                    ),
                    FloraAppBarAction(
                      flutterIcon: Icons.more_vert,
                      onPressed: () {},
                      tooltip: 'More options',
                    ),
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
                  title: 'Detail Screen',
                  leadingFlutterIcon: Icons.arrow_back,
                  onLeadingPressed: () {},
                  actions: [
                    FloraAppBarAction(
                      flutterIcon: Icons.edit,
                      onPressed: () {},
                      tooltip: 'Edit',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SampleSection(
          title: 'With progress step',
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: kToolbarHeight,
                child: FloraAppBar(
                  automaticallyImplyLeading: false,
                  leadingFlutterIcon: Icons.arrow_back,
                  onLeadingPressed: () {},
                  currentStep: 2,
                  totalSteps: 5,
                  actions: [
                    FloraAppBarAction(
                      flutterIcon: Icons.help_outline,
                      onPressed: () {},
                      tooltip: 'Help',
                    ),
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
