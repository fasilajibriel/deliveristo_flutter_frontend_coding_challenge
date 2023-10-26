import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/content.dart';
import 'package:flutter/material.dart';

/// A widget representing the user profile view.
///
/// This widget is used to display the user's profile information and settings.
/// You can customize this widget to include user details, profile picture, and
/// settings options.
///
/// Use this widget to navigate to the user profile view within your
/// application.
class ProfileView extends StatelessWidget {
  /// Creates a [ProfileView].
  ///
  /// The [key] parameter is an optional key that can be used to identify this
  /// widget in the widget tree.
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Content(
      title: "My\nProfile",
    );
  }
}
