import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/theme_constants.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class BreedsDropdown extends StatefulWidget {
  final Map<String, List<String>> dogData;

  BreedsDropdown({
    required this.dogData,
  });

  @override
  _DogBreedsDropdownState createState() => _DogBreedsDropdownState();
}

class _DogBreedsDropdownState extends State<BreedsDropdown> {
  String selectedBreed = 'Breed';
  String selectedSubBreed = 'Sub Breed';

  void onBreedSelected(String? value) {
    setState(() {
      selectedBreed = value ?? "";
    });
  }

  void onSubBreedSelected(String? value) {
    setState(() {
      selectedSubBreed = value ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownSearch<String>(
          popupProps: const PopupProps.menu(
            showSelectedItems: true,
            showSearchBox: true,
            searchDelay: Duration.zero,
          ),
          items: widget.dogData.keys.map((element) => element).toList(),
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: "Choose a breed",
            ),
          ),
          onChanged: onBreedSelected,
          selectedItem: selectedBreed,
        ),
        const SizedBox(
          height: ThemeConstants.defaultPadding,
        ),
        if (widget.dogData[selectedBreed]?.isNotEmpty ?? false)
          DropdownSearch<String>(
            popupProps: const PopupProps.menu(
              showSelectedItems: true,
              showSearchBox: true,
              searchDelay: Duration.zero,
            ),
            items: widget.dogData[selectedBreed]!.map((element) => element).toList(),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Choose a sub breed",
              ),
            ),
            onChanged: onSubBreedSelected,
            selectedItem: selectedBreed,
          ),
        if (widget.dogData[selectedBreed]?.isNotEmpty ?? false)
          const SizedBox(
            height: ThemeConstants.defaultPadding,
          ),
        // add random and list radio button
      ],
    );
  }
}
