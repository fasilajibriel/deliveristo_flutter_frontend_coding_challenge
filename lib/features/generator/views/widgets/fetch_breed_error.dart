import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/theme_constants.dart';
import 'package:flutter/material.dart';

/// Widget for displaying an error message when fetching dog breeds fails.
///
/// The `FetchBreedError` class is a StatelessWidget used to display an error
/// message when there's an issue fetching dog breed data. It shows a simple
/// error message and provides some spacing below the message.
class FetchBreedError extends StatelessWidget {
  /// Creates a [FetchBreedError] widget.
  const FetchBreedError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Center(
          child: Text("Oops, Something went wrong"),
        ),
        SizedBox(
          height: ThemeConstants.defaultPadding,
        ),
      ],
    );
  }
}
