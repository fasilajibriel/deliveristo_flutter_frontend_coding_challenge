import 'package:dartz/dartz.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/errors/api_failure.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/utils/typedef.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/onboarding/data/user/user_model.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/onboarding/service/onboarding_local_service.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/onboarding/service/onboarding_remote_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// A state management class for the onboarding process and user data.
///
/// This class manages the state of the onboarding process and user data within
/// the app. It provides methods for checking if it's the user's first time
/// using the app, signing in with Google, storing user data in Firestore,
/// saving user data to local storage, and updating the "first time" flag.
class OnboardingStateProvider with ChangeNotifier {
  var _pageState = OnboardingViewState.loading;

  UserModel _user = const UserModel.empty();

  /// Get the current state of the onboarding process.
  OnboardingViewState get getPageState => _pageState;

  /// Get the user data.
  UserModel get getUser => _user;

  /// Check if it's the user's first time using the app.
  ///
  /// This method checks if the "firstTime" flag is set to `true` in local
  /// storage using the `OnboardingLocalService`. If it's the user's first time,
  /// it updates the page state to `OnboardingViewState.success` and returns
  /// `true`. If it's not the first time, it attempts to load the user's data
  /// with `handleReturningUserData()` and returns `true` if successful. On any
  /// errors, it updates the page state to `OnboardingViewState.failed` and
  /// returns `true`.
  ///
  /// Returns `true` if it's the user's first time or if an error occurred,
  /// `false` otherwise.
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

  /// Handle the process of returning user data.
  ///
  /// This method attempts to load user data using `OnboardingLocalService`. If
  /// the user data is successfully retrieved, it updates the `_user` object and
  /// returns `true`. If the user data is not found or an error occurs, it
  /// updates the page state to `OnboardingViewState.failed` and returns `false`
  ///
  /// Returns `true` if user data is successfully loaded, `false` otherwise.
  Future<bool> handleReturningUserData() async {
    try {
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
    } catch (exception) {
      _pageState = OnboardingViewState.failed;
      notifyListeners();

      return false;
    }
  }

  /// Sign in with a Google account.
  ///
  /// This method initiates the Google Sign-In process, authenticates the user,
  /// and updates the `_user` object with the Google account information if
  /// successful.
  ///
  /// Returns `Right(true)` if the sign-in is successful, or `Left(ApiFailure)`
  /// on failure.
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

  /// Write user data to Firestore.
  ///
  /// This method sends user data to Firestore using `OnboardingRemoteServices`.
  /// If successful, it updates the `_user` object with the Firestore document
  /// ID.
  ///
  /// Returns `Right(true)` if the write operation is successful, or
  /// `Left(ApiFailure)` on failure.
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

  /// Write user data to local storage.
  ///
  /// This method stores user data in local storage using
  /// `OnboardingLocalService`. It also updates the "first time" flag in local
  /// storage.
  ///
  /// Returns `Right(true)` if both write operations are successful, or
  /// `Left(ApiFailure)` on failure.
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

  /// Update the "first time" flag in local storage.
  ///
  /// This method updates the "firstTime" flag in local storage to indicate that
  /// the user is no longer using the app for the first time.
  ///
  /// Returns `Right(true)` if the flag is successfully updated, or
  /// `Left(ApiFailure)` on failure.
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
