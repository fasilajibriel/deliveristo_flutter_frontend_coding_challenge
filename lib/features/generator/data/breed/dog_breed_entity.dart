import 'package:equatable/equatable.dart';

/// Represents a dog breed entity containing breed names and status.
///
/// The `DogBreedEntity` class is a data model that represents the response data
/// received from a dog breed API. It contains a [message] which is a map
/// associating breed categories with their sub-breeds, and a [status]
/// indicating the response status.
///
/// This class is typically used to parse and handle data related to dog breeds.
///
/// - [message]: A map associating breed categories with their sub-breeds.
/// - [status]: The response status, which can be "success" or an error message.
class DogBreedEntity extends Equatable {
  /// A map associating breed categories with their sub-breeds.
  final Map<String, List<String>>? breeds;

  /// The response status, which can be "success" or an error message.
  final String? status;

  @override
  List<Object?> get props => [breeds, status];

  /// Creates a [DogBreedEntity] with the provided [breeds] and [status].
  const DogBreedEntity({
    required this.breeds,
    required this.status,
  });
}
