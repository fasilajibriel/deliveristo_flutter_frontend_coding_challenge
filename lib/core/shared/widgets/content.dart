import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/theme_constants.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/image_grid.dart';
import 'package:flutter/material.dart';

/// A content widget for displaying the main content of the application.
///
/// The `Content` class provides a container for displaying the primary content
/// of the application. It typically includes a title and an optional
/// [ImageGrid] widget for displaying images or other content.
///
/// - [imageGrid]: An optional [ImageGrid] widget that can be provided to
/// display images or additional content.
class Content extends StatelessWidget {
  /// The optional [ImageGrid] widget for displaying images or additional
  /// content.
  final ImageGrid? imageGrid;

  /// The title to display in the content.
  final String title;

  /// Constructor for the `Content` class.
  ///
  /// The `Content` widget serves as a container for displaying the main content
  /// of the application.
  ///
  /// - [imageGrid]: An optional [ImageGrid] widget to display additional
  /// content. If not provided, it will be an empty container.
  const Content({
    required this.title,
    this.imageGrid,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(
          ThemeConstants.defaultPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: ThemeConstants.bold,
                ),
              ),
              imageGrid ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
