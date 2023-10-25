import 'package:deliveristo_flutter_frontend_coding_challenge/constants/app_constants.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const Main());
}

/// The main entry widget for your application.
///
/// The `Main` widget is the root of your application and is typically used to
/// configure the core structure and theme of the app. It sets up the
/// `MaterialApp` and defines essential properties such as the title and theme.
class Main extends StatelessWidget {
  /// Creates the `Main` widget, the root of the application.
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(),
    );
  }
}
