import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/content.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/page_title.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// A widget for displaying saved dog images.
///
/// This widget provides a view for displaying dog images that the user has
/// saved.
class SavedView extends StatefulWidget {
  /// Creates a [SavedView] widget.
  const SavedView({super.key});

  @override
  State<SavedView> createState() => _SavedViewState();
}

class _SavedViewState extends State<SavedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Content(
        child: Column(
          children: [
            const PageTitle(
              title: "Saved",
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 300.0,
                    width: 300.0,
                    child: Lottie.asset(
                      'assets/lottie/under_development.json',
                    ),
                  ),
                  const Text(
                    "Under Development!\n\nSign in to be the first\nto receive updates.",
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
