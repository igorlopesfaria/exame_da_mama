/// Flora DS — App Bar Style
library;

import 'package:flora/components/navigation/app_bar/flora_app_bar_attributes.dart';
import 'package:flora/components/progress/step/flora_progress_step_attributes.dart';
import 'package:flora/components/text/flora_text_attributes.dart';

class FloraAppBarStyle {
  const FloraAppBarStyle(this._attributes);

  final FloraAppBarAttributes _attributes;

  double get toolbarHeight => switch (_attributes.variant) {
    FloraAppBarVariant.small  => 56.0,
    FloraAppBarVariant.medium => 112.0,
    FloraAppBarVariant.large  => 152.0,
  };

  /// Typography for the title, following the Material 3 app bar spec.
  FloraTextStyle get titleTextStyle => switch (_attributes.variant) {
    FloraAppBarVariant.small  => FloraTextStyle.titleLarge,
    FloraAppBarVariant.medium => FloraTextStyle.headlineSmall,
    FloraAppBarVariant.large  => FloraTextStyle.headlineMedium,
  };

  bool get showProgressStep =>
      _attributes.currentStep != null && _attributes.totalSteps != null;

  FloraProgressStepAttributes get progressStepAttributes =>
      FloraProgressStepAttributes(
        totalSteps: _attributes.totalSteps!,
        completedSteps: _attributes.currentStep!,
      );
}
