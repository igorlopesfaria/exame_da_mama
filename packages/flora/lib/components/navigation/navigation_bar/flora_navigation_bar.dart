/// Flora DS — Navigation Bar Component
library;

import 'package:flutter/material.dart';
import 'package:flora/components/navigation/navigation_bar/flora_navigation_bar_attributes.dart';
import 'package:flora/components/navigation/navigation_bar/flora_navigation_bar_style.dart';

export 'flora_navigation_bar_attributes.dart';
export 'flora_navigation_bar_style.dart';

class FloraNavigationBar extends StatelessWidget {
  FloraNavigationBar({
    super.key,
    required List<NavigationDestination> destinations,
    required int selectedIndex,
    required ValueChanged<int> onDestinationSelected,
    NavigationDestinationLabelBehavior labelBehavior =
        NavigationDestinationLabelBehavior.alwaysShow,
    double height = 80,
  }) : _attributes = FloraNavigationBarAttributes(
         destinations: destinations,
         selectedIndex: selectedIndex,
         onDestinationSelected: onDestinationSelected,
         labelBehavior: labelBehavior,
         height: height,
       );

  final FloraNavigationBarAttributes _attributes;

  @override
  Widget build(BuildContext context) => Theme(
    data: Theme.of(context).copyWith(
      navigationBarTheme: FloraNavigationBarStyle.resolveTheme(context),
    ),
    child: NavigationBar(
      destinations: _attributes.destinations,
      selectedIndex: _attributes.selectedIndex,
      onDestinationSelected: _attributes.onDestinationSelected,
      labelBehavior: _attributes.labelBehavior,
      height: _attributes.height,
    ),
  );
}