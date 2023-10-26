import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/content.dart';
import 'package:flutter/material.dart';

/// A widget representing the Dog Image Generator view.
///
/// This widget serves as the main view for the Dog Image Generator feature. It
/// allows users to generate and view images of dogs.
///
/// Use this widget to navigate to the Dog Image Generator view within your
/// application.
class GeneratorView extends StatefulWidget {
  /// Creates a [GeneratorView].
  ///
  /// The [key] parameter is an optional key that can be used to identify this
  /// widget in the widget tree.
  const GeneratorView({super.key});

  @override
  State<GeneratorView> createState() => _GeneratorViewState();
}

class _GeneratorViewState extends State<GeneratorView> {
  @override
  Widget build(BuildContext context) {
    return const Content(
      title: "Image\nGenerator",
    );
  }
}
