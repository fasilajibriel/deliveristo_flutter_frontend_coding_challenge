import 'package:equatable/equatable.dart';

/// Represents a list of dog images along with a status.
///
/// The `ImageListEntity` class is used to encapsulate a list of dog images and
/// a status message. It is typically used to represent the response from an API
/// when fetching a list of dog images.
class ImageListEntity extends Equatable {
  /// A list of dog images.
  final List<String>? images;

  /// The status of the response.
  final String? status;

  @override
  List<Object?> get props => [images, status];

  /// Creates an [ImageListEntity] with the provided [images] and [status].
  const ImageListEntity({
    this.images,
    this.status,
  });
}
