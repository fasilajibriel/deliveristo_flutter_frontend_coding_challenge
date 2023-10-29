import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/data/breed/dog_breed_model.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/service/generator_remote_service.dart';
import 'package:flutter/material.dart';

class GeneratorStateProvider with ChangeNotifier {
  var _pageState = GeneratorViewState.loading;

  DogBreedModel _dogBreeds = DogBreedModel();

  GeneratorViewState get getPageState => _pageState;

  DogBreedModel get getDogBreeds => _dogBreeds;

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

  /// Signifies that the Dog Image Generator view has successfully completed
  success,

  /// Denotes that the Dog Image Generator view has encountered an error or
  /// failure
  failed,
}
