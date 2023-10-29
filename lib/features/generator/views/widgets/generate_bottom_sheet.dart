import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/app_constants.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/theme_constants.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/content.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/custom_button.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/loading_animation.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/data/breed/dog_breed_model.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/state/generator_state_provider.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/views/widgets/breeds_dropdown.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/views/widgets/fetch_breed_error.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/views/widgets/request_type_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A bottom sheet widget for generating dog images or lists.
///
/// This widget is used to display options for generating dog images or lists in
/// a bottom sheet.
class GenerateBottomSheet extends StatefulWidget {
  /// Creates a [GenerateBottomSheet] widget.
  const GenerateBottomSheet({super.key});

  @override
  State<GenerateBottomSheet> createState() => _GenerateBottomSheetState();
}

class _GenerateBottomSheetState extends State<GenerateBottomSheet> {
  @override
  void initState() {
    super.initState();
    context.read<GeneratorStateProvider>().fetchDogBreeds();
  }

  @override
  Widget build(BuildContext context) {
    final GeneratorViewState pageState = context.watch<GeneratorStateProvider>().getPageState;
    final DogBreedModel dogBreeds = context.watch<GeneratorStateProvider>().getDogBreeds;

    return Content(
      bottom: false,
      child: Wrap(
        children: [
          if (pageState == GeneratorViewState.loading)
            const Center(
              child: LoadingAnimation(
                size: 200.0,
              ),
            ),
          if (pageState == GeneratorViewState.success)
            BreedsDropdown(
              dogData: dogBreeds.breeds!,
            ),
          if (pageState == GeneratorViewState.success) const RequestTypeRadioButton(),
          if (pageState == GeneratorViewState.failed && dogBreeds == DogBreedModel.empty()) const FetchBreedError(),
          CustomButton(
            onTap: () {
              if (context.read<GeneratorStateProvider>().getSelectedBreed != AppConstants.breedDropdownDefaultValue) {
                context.read<GeneratorStateProvider>().generateRequest();
                Navigator.pop(context);
              }
            },
            child: const Text(
              "Generate Image",
              style: TextStyle(
                fontWeight: ThemeConstants.semiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
