import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/app_constants.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/base_layout.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/state/generator_state_provider.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/onboarding/state/onboarding_state_provider.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/onboarding/views/onboarding_view.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/saved/views/saved_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OnboardingStateProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GeneratorStateProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.appTitle,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          useMaterial3: true,
        ),
        home: const OnboardingView(),
        routes: {
          '/base': (context) => const BaseLayout(),
          '/saved': (context) => const SavedView(),
        },
      ),
    );
  }
}
