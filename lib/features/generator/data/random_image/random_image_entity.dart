import 'package:equatable/equatable.dart';

/// Represents a random dog image with a status, designed for easy
/// serialization.
///
/// The `RandomImageEntity` class provides a structured format for working with
/// random dog images and their associated status. It is used for parsing data
/// received from APIs and for serialization purposes.
class RandomImageEntity extends Equatable {
  /// The URL of the random dog image.
  final String? imageUrl;

  /// The status of the response, typically "success" or an error message.
  final String? status;

  @override
  List<Object?> get props => [imageUrl, status];

  /// Creates a [RandomImageEntity] with the provided [imageUrl] and [status].
  const RandomImageEntity({
    this.imageUrl,
    this.status,
  });
}
