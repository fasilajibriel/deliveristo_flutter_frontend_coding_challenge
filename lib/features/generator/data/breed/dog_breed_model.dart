import 'dart:convert';

import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/data/breed/dog_breed_entity.dart';

/// Represents a dog breed model that extends the [DogBreedEntity].
///
/// The `DogBreedModel` class is a data model that extends the [DogBreedEntity]
/// class. It adds methods to serialize/deserialize data and copy the model with
/// optional changes.
///
/// This class is typically used for working with dog breed data within the
/// application, including parsing data from API responses and preparing data
/// for display or storage.
class DogBreedModel extends DogBreedEntity {
  /// Creates a [DogBreedModel] with the provided [breeds] and [status].
  const DogBreedModel({
    super.breeds,
    super.status,
  });

  DogBreedModel.empty()
      : this(
          breeds: {},
          status: "_empty.status",
        );

  /// Creates a [DogBreedModel] from a JSON-encoded string.
  ///
  /// This factory method parses the JSON [data] and constructs a
  /// [DogBreedModel] object from it.
  factory DogBreedModel.fromJson(String data) {
    return DogBreedModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// Creates a [DogBreedModel] from a map of dynamic data.
  ///
  /// This factory method constructs a [DogBreedModel] object from a map
  /// [data] that includes [breeds] (associating breed categories with
  /// sub-breeds) and [status] (response status).
  factory DogBreedModel.fromMap(Map<String, dynamic> data) {
    final message = Map<String, dynamic>.from(
      data['message'] as Map<String, dynamic>,
    );
    final messageConverted = Map<String, List<String>>.fromEntries(
      message.entries.map(
        (entry) => MapEntry(
          entry.key,
          (entry.value as List).cast<String>(),
        ),
      ),
    );

    return DogBreedModel(
      breeds: messageConverted,
      status: data['status'] as String,
    );
  }

  /// Converts the [DogBreedModel] to a map of dynamic data.
  ///
  /// This method converts the model into a map that includes [breeds] (as a
  /// map of breed categories and sub-breeds) and [status] (response status).
  Map<String, dynamic> toMap() => {
        'message': breeds,
        'status': status,
      };

  /// Converts the [DogBreedModel] to a JSON-encoded string.
  ///
  /// This method serializes the model to a JSON-encoded string for data
  /// interchange or storage.
  String toJson() => json.encode(toMap());

  /// Creates a copy of the [DogBreedModel] with optional changes.
  ///
  /// This method creates a new instance of [DogBreedModel] by copying the
  /// original model's properties and applying the specified changes. Pass
  /// the new values for [breeds] or [status] to create the modified copy.
  DogBreedModel copyWith({
    Map<String, List<String>>? breeds,
    String? status,
  }) {
    return DogBreedModel(
      breeds: breeds ?? this.breeds,
      status: status ?? this.status,
    );
  }
}
