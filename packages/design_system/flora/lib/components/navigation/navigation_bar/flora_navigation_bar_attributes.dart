/// Flora DS — Navigation Bar Attributes
library;

import 'package:flutter/material.dart';

class FloraNavigationBarAttributes {
  const FloraNavigationBarAttributes({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.labelBehavior = NavigationDestinationLabelBehavior.alwaysShow,
    this.height = 80,
    this.animationDuration,
  });

  final List<NavigationDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final NavigationDestinationLabelBehavior labelBehavior;
  final double height;
  final Duration? animationDuration;
}