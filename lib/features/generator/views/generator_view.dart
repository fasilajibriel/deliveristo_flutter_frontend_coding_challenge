import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/theme_constants.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/content.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/image_grid.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/loading_animation.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/page_title.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/data/image_list/image_list_model.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/data/random_image/random_image_model.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/state/generator_state_provider.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/views/widgets/image_card.dart';
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

/// The internal state class for the [GeneratorView] widget.
///
/// The `_GeneratorViewState` class handles the state and UI logic for the
/// [GeneratorView] widget. It fetches and displays user data, a list of dog
/// images, a random dog image, and manages the view state. It includes variable
/// declarations for the [user], [imageList], [randomImage], and [pageState]
/// parameters.
class _GeneratorViewState extends State<GeneratorView> {
  @override
  Widget build(BuildContext context) {
    // Fetching user data
    final UserModel user = context.read<OnboardingStateProvider>().getUser;

    // Fetching data related to dog images and the view state
    final ImageListModel imageList = context.watch<GeneratorStateProvider>().getImageList;
    final RandomImageModel randomImage = context.watch<GeneratorStateProvider>().getRandomImage;
    final GeneratorViewState pageState = context.watch<GeneratorStateProvider>().getPageState;

    return Content(
      child: Column(
        children: [
          PageTitle(
            title: "Welcome",
            description: user != const UserModel.empty() ? user.displayName : "Guest",
            hasButton: true,
          ),
          if (pageState == GeneratorViewState.success)
            const SizedBox(
              height: ThemeConstants.defaultPadding,
            ),
          if (pageState == GeneratorViewState.fetching)
            const Expanded(
              child: Center(
                child: LoadingAnimation(size: 200.0),
              ),
            ),
          if (imageList == const ImageListModel.empty() &&
              randomImage == const RandomImageModel.empty() &&
              pageState != GeneratorViewState.fetching)
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
            ),
          if (randomImage != const RandomImageModel.empty() && pageState == GeneratorViewState.success)
            Expanded(
              child: ImageCard(imageUrl: randomImage.imageUrl ?? ""),
            ),
          if (imageList != const ImageListModel.empty() && pageState == GeneratorViewState.success)
            Expanded(
              child: ImageGrid(
                imageList: imageList,
                longPress: true,
              ),
            ),
        ],
      ),
    );
  }
}
