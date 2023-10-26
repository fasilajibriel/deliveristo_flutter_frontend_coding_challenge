import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/theme_constants.dart';
import 'package:flutter/material.dart';

/// A content widget for displaying the main content of the application.
///
/// The `Content` class provides a container for displaying the primary content
/// of the application. It typically includes a title and an optional
/// [Widget] for displaying content.
///
/// - [imageGrid]: An optional [Widget] that can be provided to display content.
class Content extends StatelessWidget {
  /// The optional [Widget] for displaying content.
  final Widget? child;

  /// Constructor for the `Content` class.
  ///
  /// The `Content` widget serves as a container for displaying the main content
  /// of the application.
  ///
  /// - [imageGrid]: An optional [Widget] to display additional
  /// content. If not provided, it will be an empty container.
  const Content({
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: ThemeConstants.defaultPadding,
          right: ThemeConstants.defaultPadding,
          top: ThemeConstants.defaultPadding,
        ),
        child: child,
      ),
    );
  }
}
