import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// A widget for displaying a loading animation.
///
/// The `LoadingAnimation` widget is used to display a loading animation in the
/// app. It provides the ability to customize the size of the loading animation.
class LoadingAnimation extends StatelessWidget {
  /// The size of the loading animation.
  final double size;

  /// Creates a `LoadingAnimation` widget with the specified size.
  ///
  /// The [size] parameter determines the width and height of the loading
  /// animation.
  const LoadingAnimation({
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Lottie.asset(
        'assets/lottie/loading.json',
      ),
    );
  }
}
