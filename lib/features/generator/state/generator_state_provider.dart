import 'package:dartz/dartz.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/app_constants.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/errors/faliure.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/utils/typedef.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/data/breed/dog_breed_model.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/data/image_list/image_list_model.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/data/random_image/random_image_model.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/service/generator_remote_service.dart';
import 'package:flutter/material.dart';

class GeneratorStateProvider with ChangeNotifier {
  var _pageState = GeneratorViewState.loading;

  DogBreedModel _dogBreeds = DogBreedModel.empty();

  ImageListModel _imagelist = const ImageListModel.empty();

  RandomImageModel _randomImage = const RandomImageModel.empty();

  int? _radioButtonValue = 0;

  String _selectedBreed = AppConstants.breedDropdownDefaultValue;

  String _selectedSubBreed = AppConstants.subBreedDropdownDefaultValue;

  GeneratorViewState get getPageState => _pageState;

  DogBreedModel get getDogBreeds => _dogBreeds;

  ImageListModel get getImageList => _imagelist;

  RandomImageModel get getRandomImage => _randomImage;

  int? get getRadioButtonValue => _radioButtonValue;

  String get getSelectedBreed => _selectedBreed;

  String get getSelectedSubBreed => _selectedSubBreed;

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

        debugPrint("Image list is not here ${left.message}");

        _pageState = GeneratorViewState.failed;
        notifyListeners();
      }, (right) {
        _imagelist = _imagelist.copyWith(
          images: right.images,
          status: right.status,
        );

        debugPrint("Image list is here");

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

        debugPrint("Image is not here ${left.message}");

        _pageState = GeneratorViewState.failed;
        notifyListeners();
      }, (right) {
        _randomImage = _randomImage.copyWith(
          imageUrl: right.imageUrl,
          status: right.status,
        );

        debugPrint("Image is here");

        _pageState = GeneratorViewState.success;
        notifyListeners();
      });
    }
  }

  void setRadioButtonValue(int? radioButtonValue) {
    _radioButtonValue = radioButtonValue;
    notifyListeners();
  }

  void setSelectedBreed(String? breed) {
    _selectedBreed = breed ?? "Breed";
    notifyListeners();
  }

  void setSelectedSubBreed(String? subBreed) {
    _selectedSubBreed = subBreed ?? "Sub Breed";
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
