import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/theme_constants.dart';
import 'package:flutter/material.dart';

/// A text widget that represents a clickable hyperlink.
///
/// The `Hyperlink` widget is used to create a text label that visually
/// represents a hyperlink and can trigger an action when clicked. It allows you
/// to define the text label and the action to be executed when the hyperlink is
/// tapped.
class Hyperlink extends StatelessWidget {
  /// A callback function that is executed when the hyperlink is tapped.
  final VoidCallback onTap;

  /// The label text to be displayed as the hyperlink.
  final String label;

  /// Creates a [Hyperlink] with the required [onTap], [label], and an optional
  /// [key].
  ///
  /// The [onTap] function is called when the hyperlink is tapped. The [label]
  /// represents the text to be displayed as the hyperlink. An optional [key]
  /// can be used to specify a key for the widget.
  const Hyperlink({
    required this.onTap,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: ThemeConstants.medium,
        ),
      ),
    );
  }
}
