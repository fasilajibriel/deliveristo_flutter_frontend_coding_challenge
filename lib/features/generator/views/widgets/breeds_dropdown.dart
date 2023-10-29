import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/theme_constants.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/services/string_extension.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/state/generator_state_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BreedsDropdown extends StatefulWidget {
  final Map<String, List<String>> dogData;

  BreedsDropdown({
    required this.dogData,
  });

  @override
  _DogBreedsDropdownState createState() => _DogBreedsDropdownState();
}

class _DogBreedsDropdownState extends State<BreedsDropdown> {
  @override
  Widget build(BuildContext context) {
    final GeneratorStateProvider generatorStateProviderListner =
        context.watch<GeneratorStateProvider>();
    final GeneratorStateProvider generatorStateProviderEvent =
        context.read<GeneratorStateProvider>();

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
          if (widget
                  .dogData[generatorStateProviderListner.getSelectedBreed
                      .toLowerCase()]
                  ?.isNotEmpty ??
              false)
            DropdownSearch<String>(
              popupProps: const PopupProps.menu(
                showSelectedItems: true,
                showSearchBox: true,
                searchDelay: Duration.zero,
              ),
              items: widget.dogData[generatorStateProviderListner
                      .getSelectedBreed
                      .toLowerCase()]!
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
          if (widget
                  .dogData[generatorStateProviderListner.getSelectedBreed
                      .toLowerCase()]
                  ?.isNotEmpty ??
              false)
            const SizedBox(
              height: ThemeConstants.defaultPadding,
            ),
        ],
      ),
    );
  }
}
