import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/theme_constants.dart';
import 'package:flutter/material.dart';

/// A widget for displaying a page title with an optional settings button.
///
/// The `PageTitle` widget is typically used to display a title for a specific
/// page or section of your application. It can include an optional settings
/// button that provides additional functionality related to the displayed
/// content.
///
/// - [title]: The title to be displayed at the top of the page.
class PageTitle extends StatelessWidget {
  /// The title to be displayed.
  final String title;

  /// Creates a [PageTitle] widget.
  ///
  /// The [title] parameter is required and specifies the text that appears as
  /// the page title. The [key] parameter is optional and can be used to
  /// identify this widget in the widget tree.
  const PageTitle({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: ThemeConstants.defaultPadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: ThemeConstants.bold,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.bookmark,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
