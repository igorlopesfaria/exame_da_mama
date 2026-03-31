/// Flora DS — Navigation Bar Style
library;

import 'package:flutter/material.dart';

abstract final class FloraNavigationBarStyle {
  static NavigationBarThemeData resolveTheme(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return NavigationBarThemeData(
      height: 80,
      backgroundColor: cs.surfaceContainer,
      surfaceTintColor: cs.surfaceTint,
      indicatorColor: cs.secondaryContainer,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return IconThemeData(color: cs.onSecondaryContainer);
        return IconThemeData(color: cs.onSurfaceVariant);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        const base = TextStyle(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5);
        if (states.contains(WidgetState.selected)) return base.copyWith(color: cs.onSecondaryContainer);
        return base.copyWith(color: cs.onSurfaceVariant);
      }),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    );
  }
}