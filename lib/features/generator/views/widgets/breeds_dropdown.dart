import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/theme_constants.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/services/string_extension.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/state/generator_state_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A dropdown widget that allows the user to select a dog breed and its
/// sub-breeds.
///
/// This widget takes a [dogData] parameter, which is a map of dog breeds to
/// their corresponding sub-breeds. The user can select a dog breed from the
/// dropdown, and if that breed has sub-breeds, they can select a sub-breed as
/// well.
///
/// The selected breed and sub-breed are provided to the parent widget through
/// the [onBreedSelected] and [onSubBreedSelected] callbacks.
class BreedsDropdown extends StatefulWidget {
  /// A map of dog breeds to their corresponding sub-breeds.
  final Map<String, List<String>> dogData;

  /// Creates a [BreedsDropdown] widget.
  ///
  /// The [dogData] parameter is required and should be a map of dog breeds to
  /// their sub-breeds.
  const BreedsDropdown({
    required this.dogData,
  });

  @override
  _DogBreedsDropdownState createState() => _DogBreedsDropdownState();
}

class _DogBreedsDropdownState extends State<BreedsDropdown> {
  @override
  Widget build(BuildContext context) {
    final GeneratorStateProvider generatorStateProviderListner = context.watch<GeneratorStateProvider>();
    final GeneratorStateProvider generatorStateProviderEvent = context.read<GeneratorStateProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: ThemeConstants.defaultPadding,
      ),
      child: Column(
        children: [
          DropdownSearch<String>(
            popupProps: const PopupProps.menu(
              showSelectedItems: true,
              showSearchBox: true,
              searchDelay: Duration.zero,
            ),
            items: widget.dogData.keys
                .map(
                  (element) => element.capitalizeFirstLetter(),
                )
                .toList(),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Choose a breed",
              ),
            ),
            onChanged: generatorStateProviderEvent.setSelectedBreed,
            selectedItem: generatorStateProviderListner.getSelectedBreed,
          ),
          const SizedBox(
            height: ThemeConstants.defaultPadding,
          ),
          if (widget.dogData[generatorStateProviderListner.getSelectedBreed.toLowerCase()]?.isNotEmpty ?? false)
            DropdownSearch<String>(
              popupProps: const PopupProps.menu(
                showSelectedItems: true,
                showSearchBox: true,
                searchDelay: Duration.zero,
              ),
              items: widget.dogData[generatorStateProviderListner.getSelectedBreed.toLowerCase()]!
                  .map(
                    (element) => element.capitalizeFirstLetter(),
                  )
                  .toList(),
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Choose a sub breed [optional]",
                ),
              ),
              onChanged: generatorStateProviderEvent.setSelectedSubBreed,
              selectedItem: generatorStateProviderListner.getSelectedSubBreed,
            ),
          if (widget.dogData[generatorStateProviderListner.getSelectedBreed.toLowerCase()]?.isNotEmpty ?? false)
            const SizedBox(
              height: ThemeConstants.defaultPadding,
            ),
        ],
      ),
    );
  }
}
