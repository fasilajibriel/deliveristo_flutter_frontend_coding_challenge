import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/theme_constants.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/content.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/custom_button.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/shared/widgets/loading_animation.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/data/breed/dog_breed_model.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/state/generator_state_provider.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/views/widgets/breeds_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GenerateBottomSheet extends StatefulWidget {
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
          if (pageState == GeneratorViewState.failed)
            const Center(
              child: Text("Oops, Something went wrong"),
            ),
          CustomButton(
            onTap: () => Navigator.pop(context),
            child: const Text(
              "Generate",
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
