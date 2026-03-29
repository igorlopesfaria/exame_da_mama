import 'package:flora/flora.dart';
import 'package:flora_sample/sample_section.dart';
import 'package:flutter/material.dart';

class FloraNavigationBarSample extends StatefulWidget {
  const FloraNavigationBarSample({super.key});

  @override
  State<FloraNavigationBarSample> createState() => _FloraNavigationBarSampleState();
}

class _FloraNavigationBarSampleState extends State<FloraNavigationBarSample> {
  int _selectedIndex = 0;
  int _selectedIndex2 = 1;

  static const _destinations = [
    NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
    NavigationDestination(icon: Icon(Icons.search_outlined), selectedIcon: Icon(Icons.search), label: 'Search'),
    NavigationDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite), label: 'Saved'),
    NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return SampleScaffold(
      title: 'Navigation Bar',
      children: [
        SampleSection(
          title: 'Interactive',
          children: [
            FloraNavigationBar(
              destinations: _destinations,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (i) => setState(() => _selectedIndex = i),
            ),
          ],
        ),
        SampleSection(
          title: 'Always show labels',
          children: [
            FloraNavigationBar(
              destinations: _destinations,
              selectedIndex: _selectedIndex2,
              onDestinationSelected: (i) => setState(() => _selectedIndex2 = i),
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            ),
          ],
        ),
        SampleSection(
          title: 'Only show selected label',
          children: [
            FloraNavigationBar(
              destinations: _destinations,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (i) => setState(() => _selectedIndex = i),
              labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            ),
          ],
        ),
        SampleSection(
          title: 'Three items',
          children: [
            FloraNavigationBar(
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(icon: Icon(Icons.notifications_outlined), selectedIcon: Icon(Icons.notifications), label: 'Alerts'),
                NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
              ],
              selectedIndex: _selectedIndex % 3,
              onDestinationSelected: (i) => setState(() => _selectedIndex = i),
            ),
          ],
        ),
      ],
    );
  }
}
