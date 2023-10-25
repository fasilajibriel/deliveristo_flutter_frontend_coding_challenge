import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/theme_constants.dart';
import 'package:flutter/material.dart';

/// A custom container widget with a clipped shape border.
///
/// The `CustomContainer` class is a custom widget that provides a clipped
/// shape border for its child widget. It clips the child widget with a
/// continuous rectangle border, creating a customized clipping effect.
///
/// This widget is useful for creating unique shapes and designs within your
/// app's layout.
class CustomContainer extends StatelessWidget {
  /// The child widget to be placed inside the custom container.
  final Widget child;

  /// Constructor for the `CustomContainer` class.
  ///
  /// The `CustomContainer` widget takes a required `child` parameter, which
  /// represents the widget to be placed inside the container. It can be used
  /// to create unique and visually appealing designs with clipped shapes.
  const CustomContainer({
    required this.child,
    super.key,
  });

  /// Builds the `CustomContainer` by clipping its child widget with a
  /// continuous rectangle border.
  ///
  /// The `build` method is responsible for creating the layout of the
  /// `CustomContainer` widget. It uses the `ClipPath` widget to apply a
  /// clipping effect to the `child` widget with a continuous rectangle border.
  /// This border is customized to have rounded corners with a radius defined by
  /// [ThemeConstants.customContainerClipperRadius].
  ///
  /// This method is automatically invoked when the `CustomContainer` widget is
  /// added to the widget tree and its layout needs to be rendered.
  ///
  /// - [context]: The build context for the widget tree.
  ///
  /// Returns the final layout, which includes the child widget clipped with the
  /// specified border shape.
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const ShapeBorderClipper(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              ThemeConstants.customContainerClipperRadius,
            ),
          ),
        ),
      ),
      child: child,
    );
  }
}
