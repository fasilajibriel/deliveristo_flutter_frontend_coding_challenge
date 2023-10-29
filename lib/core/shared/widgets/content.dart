import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/theme_constants.dart';
import 'package:flutter/material.dart';

/// A widget for wrapping content with optional padding.
///
/// The `Content` widget is used to wrap content and provides options for
/// controlling the padding on different sides. It's often used to create
/// consistent padding around child widgets while allowing customization of
/// which sides to apply padding.
///
/// - [child]: The child widget to be wrapped and padded.
/// - [left]: Set to `true` to add padding on the left side. Default is `true`.
/// - [top]: Set to `true` to add padding on the top side. Default is `true`.
/// - [right]: Set to `true` to add padding on the right side. Default is `true`.
/// - [bottom]: Set to `true` to add padding on the bottom side. Default is `true`.
class Content extends StatelessWidget {
  /// The child widget to be wrapped and padded.
  final Widget? child;

  /// Set to `true` to add padding on the left side. Default is `true`.
  final bool left;

  /// Set to `true` to add padding on the top side. Default is `true`.
  final bool top;

  /// Set to `true` to add padding on the right side. Default is `true`.
  final bool right;

  /// Set to `true` to add padding on the bottom side. Default is `true`.
  final bool bottom;

  /// Constructor for the `Content` widget.
  ///
  /// You can specify the [child] widget and choose which sides should have
  /// padding by setting [left], [top], [right], and [bottom] accordingly.
  const Content({
    this.child,
    this.left = true,
    this.top = true,
    this.right = true,
    this.bottom = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: left ? ThemeConstants.defaultPadding : 0,
          top: top ? ThemeConstants.defaultPadding : 0,
          right: right ? ThemeConstants.defaultPadding : 0,
          bottom: bottom ? ThemeConstants.defaultPadding : 0,
        ),
        child: child,
      ),
    );
  }
}
