/// Flora DS — FloraBottomSheet Component
library;

import 'package:flutter/material.dart';
import 'package:flora/components/modals/bottom_sheet/flora_bottom_sheet_attributes.dart';
import 'package:flora/components/modals/bottom_sheet/flora_bottom_sheet_style.dart';
import 'package:flora/core/tokens/flora_radius.dart';

class FloraBottomSheet {
  FloraBottomSheet({
    required Widget child,
  }) : _attributes = FloraBottomSheetAttributes(
         child: child,
       );

  final FloraBottomSheetAttributes _attributes;

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return FloraBottomSheet(
      child: child,
    )._present<T>(context, isDismissible: isDismissible, enableDrag: enableDrag);
  }

  Future<T?> _present<T>(
    BuildContext context, {
    required bool isDismissible,
    required bool enableDrag,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _FloraBottomSheetContent(attributes: _attributes),
    );
  }
}

class _FloraBottomSheetContent extends StatelessWidget {
  const _FloraBottomSheetContent({required this.attributes});

  final FloraBottomSheetAttributes attributes;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FloraBottomSheetStyle.backgroundColor(context),
        borderRadius: FloraBottomSheetStyle.topRadius,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDragHandle(context),
            Flexible(
              child: SingleChildScrollView(
                padding: FloraBottomSheetStyle.contentPadding,
                child: attributes.child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDragHandle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: FloraBottomSheetStyle.handleVerticalPadding),
      child: Container(
        width: FloraBottomSheetStyle.handleWidth,
        height: FloraBottomSheetStyle.handleHeight,
        decoration: BoxDecoration(
          color: FloraBottomSheetStyle.handleColor(context),
          borderRadius: FloraRadius.full,
        ),
      ),
    );
  }
}
