/// Flora DS — App Bar Style
library;

import 'package:flutter/material.dart';
import 'package:flora/components/navigation/app_bar/flora_app_bar_attributes.dart';

abstract final class FloraAppBarStyle {
  static double toolbarHeight(FloraAppBarVariant variant) => switch (variant) {
    FloraAppBarVariant.small  => kToolbarHeight,
    FloraAppBarVariant.medium => 112,
    FloraAppBarVariant.large  => 152,
  };
}