import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/theme_constants.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/content.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/custom_button.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/state/generator_state_provider.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/onboarding/state/onboarding_state_provider.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/onboarding/views/widgets/hyperlink.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

/// Represents an onboarding view in the application.
///
/// The `OnboardingView` is a stateful widget used to display an onboarding
/// screen to introduce new users to the application. It typically contains
/// introductory information, images, and navigation controls to guide users
/// through the initial setup or usage instructions.
class OnboardingView extends StatefulWidget {
  /// Creates an [OnboardingView] with an optional key.
  ///
  /// The optional [key] argument allows specifying a key for the widget.
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  @override
  void initState() {
    super.initState();
    context.read<OnboardingStateProvider>().checkFirstTime();
  }

  @override
  Widget build(BuildContext context) {
    OnboardingViewState pageState = context.watch<OnboardingStateProvider>().getPageState;

    return Scaffold(
      body: Content(
        child: Column(
          children: [
            Expanded(child: Container()),
            if (context.watch<OnboardingStateProvider>().getPageState == OnboardingViewState.loading)
              SizedBox(
                width: 100.0,
                height: 100.0,
                child: Lottie.asset(
                  'assets/lottie/loading.json',
                ),
              ),
            if (pageState != OnboardingViewState.loading)
              CustomButton(
                onTap: () {},
                leadingIcon: true,
                child: const Text(
                  "Continue with Google",
                  style: TextStyle(
                    fontWeight: ThemeConstants.semiBold,
                  ),
                ),
              ),
            const SizedBox(
              height: ThemeConstants.defaultPadding,
            ),
            if (pageState != OnboardingViewState.loading)
              Hyperlink(
                onTap: () async {
                  await context.read<GeneratorStateProvider>().fetchDogBreeds();
                  if (pageState != OnboardingViewState.loading) {
                    Navigator.pushNamed(context, '/base');
                  }
                },
                label: "Skip",
              ),
          ],
        ),
      ),
    );
  }
}
