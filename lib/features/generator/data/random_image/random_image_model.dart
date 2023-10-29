import 'dart:convert';

import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/data/random_image/random_image_entity.dart';

/// Represents a model for a random dog image with a status, designed for easy
/// serialization.
///
/// The `RandomImageModel` class extends `RandomImageEntity` and provides
/// methods for parsing, serializing, and copying instances of random dog
/// images. It includes variable declarations for the image URL and status,
/// which are typically received from APIs or used for serialization.
class RandomImageModel extends RandomImageEntity {
  @override
  List<Object?> get props => [imageUrl, status];

  /// Creates a [RandomImageModel] with the provided [imageUrl] and [status].
  const RandomImageModel({
    super.imageUrl,
    super.status,
  });

  /// Creates a [RandomImageModel] with empty values.
  const RandomImageModel.empty()
      : this(
          imageUrl: null,
          status: "_empty.status",
        );

  /// Parses a JSON string and returns the resulting [RandomImageModel]
  /// instance.
  ///
  /// This method takes a JSON string, typically received from a network
  /// response, and parses it to create a [RandomImageModel] instance using the
  /// 'message' field as the image URL and the 'status' field for status
  /// information.
  factory RandomImageModel.fromJson(String data) {
    return RandomImageModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// Parses a JSON map and returns a [RandomImageModel] instance.
  ///
  /// This method takes a [Map] of data, typically received from a JSON
  /// response, and constructs a [RandomImageModel] instance using the 'message'
  /// field as the image URL and the 'status' field for status information.
  factory RandomImageModel.fromMap(Map<String, dynamic> data) {
    return RandomImageModel(
      imageUrl: data['message'] as String?,
      status: data['status'] as String?,
    );
  }

  /// Converts a [RandomImageModel] instance to a JSON map.
  ///
  /// This method converts the [RandomImageModel] instance to a [Map] that can
  /// be easily serialized to JSON. It includes the image URL as 'message' and
  /// the status information.
  Map<String, dynamic> toMap() => {
        'message': imageUrl,
        'status': status,
      };

  /// Converts a [RandomImageModel] instance to a JSON string.
  ///
  /// This method serializes the [RandomImageModel] instance to a JSON-formatted
  /// string, which can be used for various data exchange purposes.
  String toJson() => json.encode(toMap());

  /// Creates a copy of this [RandomImageModel] with the option to modify its
  /// properties.
  ///
  /// This method creates a new [RandomImageModel] instance by copying the
  /// existing instance and applying changes as specified. The [imageUrl] and
  /// [status] can be updated while preserving the original values.
  RandomImageModel copyWith({
    String? imageUrl,
    String? status,
  }) {
    return RandomImageModel(
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
    );
  }
}
