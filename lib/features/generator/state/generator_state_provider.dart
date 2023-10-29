import 'package:dartz/dartz.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/app_constants.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/errors/faliure.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/data/breed/dog_breed_model.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/data/image_list/image_list_model.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/data/random_image/random_image_model.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/service/generator_remote_service.dart';
import 'package:flutter/material.dart';

/// Provider class responsible for managing the state of the dog breed generator
/// feature.
class GeneratorStateProvider with ChangeNotifier {
  /// Represents the current state of the dog breed generator feature.
  var _pageState = GeneratorViewState.loading;

  /// Represents the model containing information about available dog breeds.
  DogBreedModel _dogBreeds = const DogBreedModel.empty();

  /// Represents the model containing a list of dog breed images.
  ImageListModel _imagelist = const ImageListModel.empty();

  /// Represents the model containing a random dog breed image.
  RandomImageModel _randomImage = const RandomImageModel.empty();

  /// Represents the value of the selected radio button, where 0 corresponds to
  /// generating a random image, and 1 to generating a list of images.
  int? _radioButtonValue = 0;

  /// Represents the selected dog breed from the dropdown, with a default value
  /// of "Breed."
  String _selectedBreed = AppConstants.breedDropdownDefaultValue;

  /// Represents the selected sub-breed from the dropdown, with a default value
  /// of "Sub Breed."
  String _selectedSubBreed = AppConstants.subBreedDropdownDefaultValue;

  /// Gets the current state of the dog breed generator feature.
  GeneratorViewState get getPageState => _pageState;

  /// Gets the model containing information about available dog breeds.
  DogBreedModel get getDogBreeds => _dogBreeds;

  /// Gets the model containing a list of dog breed images.
  ImageListModel get getImageList => _imagelist;

  /// Gets the model containing a random dog breed image.
  RandomImageModel get getRandomImage => _randomImage;

  /// Gets the value of the selected radio button.
  int? get getRadioButtonValue => _radioButtonValue;

  /// Gets the selected dog breed from the dropdown.
  String get getSelectedBreed => _selectedBreed;

  /// Gets the selected sub-breed from the dropdown.
  String get getSelectedSubBreed => _selectedSubBreed;

  /// Fetches the list of available dog breeds.
  ///
  /// Retrieves the list of available dog breeds and updates the [_dogBreeds]
  /// property. If successful, sets the [GeneratorViewState] to
  /// [GeneratorViewState.success], otherwise to [GeneratorViewState.failed].
  Future<void> fetchDogBreeds() async {
    final dogBreeds = await GeneratorRemoteService.getDogBreeds();

    dogBreeds.fold(
      (left) {
        _pageState = GeneratorViewState.failed;
        notifyListeners();
      },
      (right) {
        _dogBreeds = right;
        _pageState = GeneratorViewState.success;
        notifyListeners();
      },
    );
  }

  /// Generates dog breed images or a random dog breed image based on user
  /// selection.
  ///
  /// Initiates the process of generating dog breed images or a random dog breed
  /// image based on user selection. It sets the [GeneratorViewState] to
  /// [GeneratorViewState.fetching] while the request is in progress. On
  /// successful generation, it updates the [_imagelist] or [_randomImage]
  /// property and sets the [GeneratorViewState] to [GeneratorViewState.success]
  Future<void> generateRequest() async {
    _imagelist = const ImageListModel.empty();
    _randomImage = const RandomImageModel.empty();

    _pageState = GeneratorViewState.fetching;
    notifyListeners();

    if (_radioButtonValue == 1) {
      final Either<Faliure, ImageListModel> generatedImageList;
      generatedImageList = _selectedSubBreed == AppConstants.subBreedDropdownDefaultValue
          ? await GeneratorRemoteService.generateBreedImageList(
              breed: _selectedBreed.toLowerCase(),
            )
          : await GeneratorRemoteService.generateSubBreedImageList(
              breed: _selectedBreed.toLowerCase(),
              subBreed: _selectedSubBreed.toLowerCase(),
            );

      generatedImageList.fold((left) {
        _imagelist = const ImageListModel.empty();

        _pageState = GeneratorViewState.failed;
        notifyListeners();
      }, (right) {
        _imagelist = _imagelist.copyWith(
          images: right.images,
          status: right.status,
        );

        _pageState = GeneratorViewState.success;
        notifyListeners();
      });
    } else {
      final Either<Faliure, RandomImageModel> generatedRandomImage;

      generatedRandomImage = _selectedSubBreed == AppConstants.subBreedDropdownDefaultValue
          ? await GeneratorRemoteService.generateBreedRandomImage(
              breed: _selectedBreed.toLowerCase(),
            )
          : await GeneratorRemoteService.generateSubBreedRandomImage(
              breed: _selectedBreed.toLowerCase(),
              subBreed: _selectedSubBreed.toLowerCase(),
            );

      generatedRandomImage.fold((left) {
        _randomImage = const RandomImageModel.empty();

        _pageState = GeneratorViewState.failed;
        notifyListeners();
      }, (right) {
        _randomImage = _randomImage.copyWith(
          imageUrl: right.imageUrl,
          status: right.status,
        );

        _pageState = GeneratorViewState.success;
        notifyListeners();
      });
    }
  }

  /// Sets the radio button value based on user selection.
  ///
  /// Updates the [_radioButtonValue] property based on user selection and
  /// notifies listeners.
  void setRadioButtonValue(int? radioButtonValue) {
    _radioButtonValue = radioButtonValue;
    notifyListeners();
  }

  /// Sets the selected dog breed based on user selection.
  ///
  /// Updates the [_selectedBreed] property based on user selection and notifies
  /// listeners.
  void setSelectedBreed(String? breed) {
    _selectedBreed = breed ?? AppConstants.breedDropdownDefaultValue;
    notifyListeners();
  }

  /// Sets the selected sub-breed based on user selection.
  ///
  /// Updates the [_selectedSubBreed] property based on user selection and
  /// notifies listeners.
  void setSelectedSubBreed(String? subBreed) {
    _selectedSubBreed = subBreed ?? AppConstants.subBreedDropdownDefaultValue;
    notifyListeners();
  }
}

/// Enumerates the possible states of the Dog Image Generator view.
///
/// The `GeneratorViewState` enum defines the different states that the Dog
/// Image Generator view can be in. These states help track the progress of the
/// generator and handle various scenarios, including the initial setup,
/// loading data, success, or failure.
enum GeneratorViewState {
  /// Represents the initial state of the Dog Image Generator view.
  initial,

  /// Indicates that the Dog Image Generator view is currently loading
  loading,

  /// Indicates that the Dog Image Generator view is currently fetching data
  fetching,

  /// Signifies that the Dog Image Generator view has successfully completed
  success,

  /// Denotes that the Dog Image Generator view has encountered an error or
  /// failure
  failed,
}
