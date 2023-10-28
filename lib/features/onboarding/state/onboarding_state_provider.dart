import 'package:deliveristo_flutter_frontend_coding_challenge/features/onboarding/service/onboarding_remote_services.dart';
import 'package:flutter/material.dart';

class OnboardingStateProvider with ChangeNotifier {
  /// The current status of the onboarding page.
  var _pageState = OnboardingViewState.loading;

  /// Getter method to retrieve the current onboarding page status.
  OnboardingViewState get getPageState => _pageState;

  Future<void> checkFirstTime() async {
    await Future.delayed(Duration(seconds: 1));

    _pageState = OnboardingViewState.success;
    notifyListeners();
  }
}

/// Enumerates the possible states of the onboarding process.
///
/// The `OnboardingViewState` enum defines the different states that the
/// onboarding process can be in. These states help track the progress of the
/// onboarding and handle various scenarios such as initial setup, loading data,
/// success, or failure.
enum OnboardingViewState {
  /// Represents the initial state of the onboarding process.
  initial,

  /// Indicates that the onboarding process is currently loading data or
  /// performing some background tasks.
  loading,

  /// Signifies that the onboarding process has completed successfully.
  success,

  /// Denotes that the onboarding process has encountered an error or failure.
  failed,
}
