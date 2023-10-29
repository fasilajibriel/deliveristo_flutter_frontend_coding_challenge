import 'dart:convert';

import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/data/image_list/image_list_entity.dart';

/// Represents a list of dog images with a status, designed for easy
/// serialization.
///
/// The `ImageListModel` class extends [ImageListEntity] and provides methods
/// for serializing and deserializing data. It is typically used for working
/// with dog image lists in a structured format, including JSON.
class ImageListModel extends ImageListEntity {
  @override
  List<Object?> get props => [images, status];

  /// Creates an [ImageListModel] with the provided [images] and [status].
  const ImageListModel({
    super.images,
    super.status,
  });

  /// Factory method to parse a JSON string and create an [ImageListModel].
  factory ImageListModel.fromJson(String data) {
    return ImageListModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// Creates an empty [ImageListModel] with default values.
  const ImageListModel.empty() : super(images: null, status: "_empty.status");

  /// Factory method to create an [ImageListModel] from a map.
  factory ImageListModel.fromMap(Map<String, dynamic> data) {
    return ImageListModel(
      images: data['message'].cast<String>() as List<String>?,
      status: data['status'] as String?,
    );
  }

  /// Converts the [ImageListModel] to a map for serialization.
  Map<String, dynamic> toMap() => {
        'message': images,
        'status': status,
      };

  /// Converts the [ImageListModel] to a JSON string.
  String toJson() => json.encode(toMap());

  /// Creates a new [ImageListModel] with optional property changes.
  ImageListModel copyWith({
    List<String>? images,
    String? status,
  }) {
    return ImageListModel(
      images: images ?? this.images,
      status: status ?? this.status,
    );
  }
}
