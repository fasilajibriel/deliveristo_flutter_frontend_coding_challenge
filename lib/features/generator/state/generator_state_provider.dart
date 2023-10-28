import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/service/generator_remote_service.dart';
import 'package:flutter/material.dart';

/// A provider class responsible for managing the state of the Dog Image
/// Generator view.
///
/// The `GeneratorStateProvider` class handles the state of the Dog Image
/// Generator view, which includes tracking the current view state and fetching
/// dog breeds. It notifies listeners of state changes and encapsulates the
/// logic for managing the view's behavior.
class GeneratorStateProvider with ChangeNotifier {
  /// The current state of the Dog Image Generator view.
  var _pageState = GeneratorViewState.loading;

  /// Getter to retrieve the current view state.
  GeneratorViewState get getPageState => _pageState;

  /// Asynchronously fetches a list of dog breeds.
  ///
  /// This method triggers the process of fetching dog breeds for the Generator
  /// view. It updates the view state to 'loading' and notifies listeners. After
  /// completing the data retrieval, it updates the state to 'failed' or
  /// 'success' based on the outcome and notifies listeners again.
  Future<void> fetchDogBreeds() async {
    _pageState = GeneratorViewState.loading;
    notifyListeners();

    final dogBreeds = await GeneratorRemoteService.getDogBreeds();

    dogBreeds.fold(
      (l) {
        // Set the view state to 'failed' if an error occurred.
        _pageState = GeneratorViewState.failed;
      },
      (r) {
        // Set the view state to 'success' if the operation completed successfully.
        _pageState = GeneratorViewState.success;
      },
    );

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

  /// Signifies that the Dog Image Generator view has successfully completed
  success,

  /// Denotes that the Dog Image Generator view has encountered an error or
  /// failure
  failed,
}
