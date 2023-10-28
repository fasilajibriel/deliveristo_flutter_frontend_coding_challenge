import 'package:dartz/dartz.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/errors/api_failure.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/utils/typedef.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/onboarding/data/user/user_model.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/onboarding/service/onboarding_local_service.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/onboarding/service/onboarding_remote_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class OnboardingStateProvider with ChangeNotifier {
  var _pageState = OnboardingViewState.loading;

  UserModel _user = const UserModel.empty();

  OnboardingViewState get getPageState => _pageState;

  UserModel get getUser => _user;

  Future<bool> checkFirstTime() async {
    try {
      final bool isFirstTime = await OnboardingLocalService.readIsFirstBool();

      if (isFirstTime) {
        _pageState = OnboardingViewState.success;
        notifyListeners();

        return true;
      } else {
        final bool returnUserHandlerResult = await handleReturningUserData();

        return !returnUserHandlerResult;
      }
    } catch (exception) {
      _pageState = OnboardingViewState.failed;
      notifyListeners();

      return true;
    }
  }

  Future<bool> handleReturningUserData() async {
    final UserModel user = await OnboardingLocalService.readUserObject();

    if (user == const UserModel.empty()) {
      _pageState = OnboardingViewState.failed;
      notifyListeners();

      return false;
    }

    _user = _user.copyWith(
      documentId: user.documentId,
      displayName: user.displayName,
      photoUrl: user.photoUrl,
      email: user.email,
    );

    return true;
  }

  FutureResult<bool> signInWithGoogle() async {
    _pageState = OnboardingViewState.loading;
    notifyListeners();

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return const Left(ApiFailure(message: "Google sign in cancelled."));
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);

      if (authResult.user == null) {
        _pageState = OnboardingViewState.failed;
        notifyListeners();

        return const Left(ApiFailure(message: "User not found."));
      } else {
        _user = _user.copyWith(
          displayName: authResult.user?.displayName,
          email: authResult.user?.email,
          photoUrl: authResult.user?.photoURL,
        );

        return const Right(true);
      }
    } catch (exception) {
      _pageState = OnboardingViewState.failed;
      notifyListeners();

      return Left(ApiFailure(message: exception.toString()));
    }
  }

  FutureResult<bool> writeUserToFirestore() async {
    try {
      final writeToFirestoreResult = await OnboardingRemoteServices.writeUserToFirestore(
        user: _user,
      );

      if (writeToFirestoreResult.isLeft()) {
        final failure = writeToFirestoreResult.fold((l) => l, (r) => null);

        return Left(failure ?? const ApiFailure(message: "message"));
      }

      final UserModel? user = writeToFirestoreResult.fold(
        (failure) => null,
        (user) => user,
      );

      if (user != null) {
        _user = _user.copyWith(documentId: user.documentId);
      }

      return const Right(true);
    } catch (exception) {
      _pageState = OnboardingViewState.failed;
      notifyListeners();

      return Left(ApiFailure(message: exception.toString()));
    }
  }

  FutureResult<bool> writeUserToLocalStorage() async {
    try {
      final writeToLocalResult = await OnboardingLocalService.writeUserObject(
        user: _user,
      );
      final updateIsFirstTimeResult = await OnboardingLocalService.writeIsFirstBool(
        isFirstTime: false,
      );

      return Right(writeToLocalResult && updateIsFirstTimeResult);
    } catch (exception) {
      _pageState = OnboardingViewState.failed;
      notifyListeners();

      return Left(ApiFailure(message: exception.toString()));
    }
  }

  FutureResult<bool> writeisFirstTimeToLocalStorage() async {
    try {
      final updateIsFirstTimeResult = await OnboardingLocalService.writeIsFirstBool(
        isFirstTime: false,
      );

      return Right(updateIsFirstTimeResult);
    } catch (exception) {
      _pageState = OnboardingViewState.failed;
      notifyListeners();

      return Left(ApiFailure(message: exception.toString()));
    }
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
