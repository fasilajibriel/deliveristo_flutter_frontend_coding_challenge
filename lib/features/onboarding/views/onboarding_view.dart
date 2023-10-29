import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/theme_constants.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/content.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/custom_button.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/loading_animation.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/onboarding/state/onboarding_state_provider.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/onboarding/views/widgets/hyperlink.dart';
import 'package:flutter/material.dart';
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
    context.read<OnboardingStateProvider>().checkFirstTime().then((isFirstTime) {
      if (!isFirstTime) {
        Navigator.pushReplacementNamed(context, "/base");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final OnboardingViewState pageState = context.watch<OnboardingStateProvider>().getPageState;

    return Scaffold(
      body: Content(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset("assets/images/d_icon.png"),
                ),
              ),
            ),
            if (pageState == OnboardingViewState.loading)
              const LoadingAnimation(
                size: 100.0,
              ),
            if (pageState != OnboardingViewState.loading)
              CustomButton(
                onTap: () async {
                  try {
                    final signInResult = await context.read<OnboardingStateProvider>().signInWithGoogle();

                    signInResult.fold(
                      (left) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(left.message),
                          ),
                        );
                      },
                      (right) async {
                        final writeUserResult = await context.read<OnboardingStateProvider>().writeUserToFirestore();

                        writeUserResult.fold(
                          (left) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(left.message),
                              ),
                            );
                          },
                          (right) async {
                            final writeLocalStorageResult =
                                await context.read<OnboardingStateProvider>().writeUserToLocalStorage();

                            writeLocalStorageResult.fold(
                              (left) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(left.message),
                                  ),
                                );
                              },
                              (right) {
                                if (right) {
                                  Navigator.pushReplacementNamed(context, "/base");
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Unable to store user data. Please try again!",
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        );
                      },
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Oops! Something went wrong. Please try again",
                        ),
                      ),
                    );
                  }
                },
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
                  final writeLocalStorageResult =
                      await context.read<OnboardingStateProvider>().writeisFirstTimeToLocalStorage();

                  writeLocalStorageResult.fold(
                    (left) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(left.message),
                        ),
                      );
                    },
                    (right) {
                      if (right) {
                        Navigator.pushReplacementNamed(context, "/base");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Unable to store user data. Please try again!",
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
                label: "Skip",
              ),
          ],
        ),
      ),
    );
  }
}
