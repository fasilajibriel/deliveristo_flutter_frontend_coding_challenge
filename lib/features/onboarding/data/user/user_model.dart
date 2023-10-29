import 'dart:convert';

import 'package:deliveristo_flutter_frontend_coding_challenge/features/onboarding/data/user/user_entity.dart';

/// Represents a user model with extended functionality.
///
/// The `UserModel` class extends the base `UserEntity` class and provides
/// additional methods and constructors for working with user data. It retains
/// properties such as `documentId`, `displayName`, `email`, and `photoUrl`. It
/// implements `Equatable` to facilitate comparisons and equality checks based
/// on its properties.
class UserModel extends UserEntity {
  @override
  List<Object?> get props => [documentId, displayName, email, photoUrl];

  /// Creates a new `UserModel` instance.
  ///
  /// The constructor takes optional parameters to initialize the user model
  /// with its properties.
  ///
  /// - [documentId]: The unique document ID associated with the user.
  /// - [displayName]: The user's display name or username.
  /// - [email]: The user's email address.
  /// - [photoUrl]: The URL to the user's profile photo.
  const UserModel({
    super.documentId,
    super.displayName,
    super.email,
    super.photoUrl,
  });

  /// Creates an empty `UserModel` instance.
  ///
  /// The `UserModel.empty()` constructor is used to create an instance of the
  /// `UserModel` class with default or placeholder values. This can be helpful
  /// when you need to represent a user with empty or unknown information. The
  /// default values include:
  ///
  /// - [documentId]: A placeholder document ID string.
  /// - [displayName]: A placeholder display name string.
  /// - [email]: A placeholder email address string.
  /// - [photoUrl]: A placeholder photo URL string.
  ///
  /// This constructor is useful when you want to handle cases where user
  /// information is not available or needs to be initialized with empty values.
  const UserModel.empty()
      : this(
          documentId: "_empty.documentId",
          displayName: "_empty.displayName",
          email: "_empty.email",
          photoUrl: "_empty.photoUrl",
        );

  /// Parses a JSON string and returns a `UserModel` instance.
  ///
  /// This factory constructor parses a JSON string and constructs a `UserModel`
  /// instance using the decoded data. It is useful for deserializing data from
  /// JSON format.
  factory UserModel.fromJson(String data) {
    return UserModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// Creates a `UserModel` instance from a map of data.
  ///
  /// This factory constructor takes a `Map` of data and constructs a
  /// `UserModel` instance using the provided data. It is useful for converting
  /// data retrieved from a data source into a user model.
  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
        documentId: data['document_id'] as String?,
        displayName: data['display_name'] as String?,
        email: data['email'] as String?,
        photoUrl: data['photo_url'] as String?,
      );

  /// Converts the user model to a `Map` of data.
  ///
  /// This method converts the user model into a `Map` of data, making it
  /// suitable for storage or serialization. The resulting map includes
  /// properties such as `documentId`, `displayName`, `email`, and `photoUrl`.
  Map<String, dynamic> toMap() => {
        'document_id': documentId,
        'display_name': displayName,
        'email': email,
        'photo_url': photoUrl,
      };

  /// Converts the user model to a JSON string.
  ///
  /// This method serializes the user model into a JSON string, making it
  /// suitable for sending data over the network or storing in JSON format.
  String toJson() => json.encode(toMap());

  /// Creates a new `UserModel` instance with updated properties.
  ///
  /// This method generates a new `UserModel` instance with properties updated
  /// using the provided values. Any non-null values will replace the
  /// corresponding properties of the original user model.
  ///
  /// - [documentId]: The unique document ID associated with the user.
  /// - [displayName]: The user's display name or username.
  /// - [email]: The user's email address.
  /// - [photoUrl]: The URL to the user's profile photo.
  UserModel copyWith({
    String? documentId,
    String? displayName,
    String? email,
    String? photoUrl,
  }) {
    return UserModel(
      documentId: documentId ?? this.documentId,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
