import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/theme_constants.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/content.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/custom_container.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/page_title.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/onboarding/data/user/user_model.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/onboarding/state/onboarding_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

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
    final UserModel user = context.read<OnboardingStateProvider>().getUser;
    final Size window = MediaQuery.of(context).size;

    return Content(
      child: Column(
        children: [
          PageTitle(
            title: "Welcome",
            description: user != const UserModel.empty() ? user.displayName : null,
          ),
          // const SizedBox(
          //   height: ThemeConstants.defaultPadding,
          // ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Lottie.asset(
                      'assets/lottie/generate_empty.json',
                    ),
                  ),
                  const Text(
                    "Hmm, what does\nthis button do?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          )

          // Expanded(
          //   child: CustomContainer(
          //     child: Container(
          //       color: Colors.grey[400],
          //     ),
          //   ),
          // ),
          // Expanded(
          //   child: GridView.builder(
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       childAspectRatio: 0.75,
          //       mainAxisSpacing: ThemeConstants.defaultPadding,
          //       crossAxisSpacing: ThemeConstants.defaultPadding,
          //     ),
          //     itemCount: 10,
          //     itemBuilder: (context, index) {
          //       return CustomContainer(
          //         child: Container(
          //           color: Colors.grey[400],
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
