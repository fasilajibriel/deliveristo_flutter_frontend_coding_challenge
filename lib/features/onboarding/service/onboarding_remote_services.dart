import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/firebase_api_constants.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/errors/api_failure.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/utils/typedef.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/onboarding/data/user/user_model.dart';

/// Provides methods for remote services related to onboarding processes.
///
/// The `OnboardingRemoteServices` class contains static methods for interacting
/// with remote services, specifically for user registration and other
/// onboarding processes. It offers a convenient way to communicate with remote
/// data sources, such as Firestore or APIs, and handle user-related operations.
class OnboardingRemoteServices {
  /// Writes user data to Firestore and returns the registered user.
  ///
  /// This method takes a [user] object of type [UserModel] and attempts to
  /// register the user in Firestore. If successful, it returns a [UserModel]
  /// object representing the registered user with an assigned document ID.
  /// If any error occurs during the registration process, it returns a
  /// [Left] value of [ApiFailure] containing an error message and status code.
  static FutureResult<UserModel> writeUserToFirestore({
    required UserModel user,
  }) async {
    try {
      final FirebaseFirestore firebaseFirestoreInstance =
          FirebaseFirestore.instance;
      final CollectionReference usersCollectionReference =
          firebaseFirestoreInstance.collection(
        FirebaseApiConstants.usersCollection,
      );

      await usersCollectionReference.add(user.toMap()).then((value) async {
        user = user.copyWith(documentId: value.id);

        await usersCollectionReference.doc(user.documentId).update(
          {"document_id": value.id},
        );
      });

      return Right(user);
    } catch (exception) {
      return const Left(
        ApiFailure(
          message: "Unable to register user. Please try again",
          statusCode: 500,
        ),
      );
    }
  }
}
