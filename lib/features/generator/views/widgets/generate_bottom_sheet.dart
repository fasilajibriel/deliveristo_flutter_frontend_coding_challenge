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
  String selectedBreed = 'Breed';
  String selectedSubBreed = 'Sub Breed';

  void onBreedSelected(String? value) {
    setState(() {
      selectedBreed = value!;
    });
  }

  void onSubBreedSelected(String? value) {
    setState(() {
      selectedSubBreed = value!;
    });
  }

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
          // Column(
          //   children: [
          //     DropdownSearch<String>(
          //       popupProps: const PopupProps.menu(
          //         showSelectedItems: true,
          //         showSearchBox: true,
          //         searchDelay: Duration.zero,
          //       ),
          //       items: dogBreeds.breeds!.keys.map((element) => element).toList(),
          //       dropdownDecoratorProps: const DropDownDecoratorProps(
          //         dropdownSearchDecoration: InputDecoration(
          //           labelText: "Choose a breed",
          //         ),
          //       ),
          //       onChanged: (value) {
          //         setState(() {
          //           selectedBreed = value ?? "";
          //         });
          //       },
          //       selectedItem: selectedBreed,
          //     ),
          //     const SizedBox(
          //       height: ThemeConstants.defaultPadding,
          //     ),
          //     if (dogBreeds.breeds?[selectedBreed]?.isNotEmpty ?? false)
          //       DropdownSearch<String>(
          //         popupProps: const PopupProps.menu(
          //           showSelectedItems: true,
          //           showSearchBox: true,
          //           searchDelay: Duration.zero,
          //         ),
          //         items: dogBreeds.breeds![selectedBreed]!.map((element) => element).toList(),
          //         dropdownDecoratorProps: const DropDownDecoratorProps(
          //           dropdownSearchDecoration: InputDecoration(
          //             labelText: "Choose a sub breed",
          //           ),
          //         ),
          //         onChanged: (value) {
          //           setState(() {
          //             selectedSubBreed = value ?? "";
          //           });
          //         },
          //         selectedItem: selectedSubBreed,
          //       ),
          //     const SizedBox(
          //       height: ThemeConstants.defaultPadding,
          //     ),
          //   ],
          // ),
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
