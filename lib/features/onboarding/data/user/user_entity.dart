import 'package:equatable/equatable.dart';

/// Represents a user entity with essential information.
///
/// The `UserEntity` class defines a user entity with attributes such as `documentId`,
/// `displayName`, `email`, and `photoUrl`. This entity is used to encapsulate and transport
/// essential user data within the application. It implements `Equatable` to facilitate
/// comparisons and equality checks based on its properties.
class UserEntity extends Equatable {
  /// The unique document ID associated with the user entity.
  final String? documentId;

  /// The user's display name or username.
  final String? displayName;

  /// The user's email address.
  final String? email;

  /// The URL to the user's profile photo.
  final String? photoUrl;

  @override
  List<Object?> get props => [documentId, displayName, email, photoUrl];

  /// Creates a new `UserEntity` instance.
  ///
  /// The constructor takes optional parameters to initialize the user entity
  /// with its properties.
  ///
  /// - [documentId]: The unique document ID associated with the user.
  /// - [displayName]: The user's display name or username.
  /// - [email]: The user's email address.
  /// - [photoUrl]: The URL to the user's profile photo.
  const UserEntity({
    this.documentId,
    this.displayName,
    this.email,
    this.photoUrl,
  });
}
