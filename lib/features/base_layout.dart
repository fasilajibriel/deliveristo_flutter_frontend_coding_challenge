import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/presentation/views/generator_view.dart';
import 'package:flutter/material.dart';

/// A base layout widget for building the core structure of the application.
///
/// The `BaseLayout` class provides the fundamental structure for the
/// application's user interface. It serves as a starting point for creating a
/// layout with a common structure, such as a scaffold, app bar, or navigation
/// bar. Developers can extend this class to customize and build upon the core
/// layout of the application.
class BaseLayout extends StatefulWidget {
  /// Constructor for the `BaseLayout` class.
  ///
  /// The `BaseLayout` widget offers a starting point for creating a layout
  /// structure or your application. It is typically used as the parent widget
  /// for defining the ore layout, such as the scaffold, app bar, or navigation
  /// bar.
  const BaseLayout({super.key});

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const GeneratorView(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Generate"),
        icon: const Icon(Icons.shape_line_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
