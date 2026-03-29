import 'package:flutter/material.dart';

abstract final class FloraRadius {
  static const none       = BorderRadius.zero;
  static const extraSmall = BorderRadius.all(Radius.circular(4));
  static const small      = BorderRadius.all(Radius.circular(8));
  static const medium     = BorderRadius.all(Radius.circular(12));
  static const large      = BorderRadius.all(Radius.circular(16));
  static const extraLarge = BorderRadius.all(Radius.circular(28));
  static const full       = BorderRadius.all(Radius.circular(9999));

  // Shape values (double)
  static const double noneValue       = 0;
  static const double extraSmallValue = 4;
  static const double smallValue      = 8;
  static const double mediumValue     = 12;
  static const double largeValue      = 16;
  static const double extraLargeValue = 28;
  static const double fullValue       = 9999;
}
