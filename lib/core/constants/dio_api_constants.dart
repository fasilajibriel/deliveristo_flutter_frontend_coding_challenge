/// Constants for Dio API endpoints related to dog breeds.
///
/// The `DioApiConstants` class provides static constants for defining API
/// endpoints used to retrieve information about dog breeds and images.
class DioApiConstants {
  /// The base URL for the Dog CEO API.
  static const String baseUrl = "https://dog.ceo/api";

  static const String breed = "$baseUrl/breed";
  static const String breeds = "$baseUrl/breeds";

  /// Endpoint to get the list of all dog breeds.
  static const String getBreedList = "$breeds/list/all";

  /// Endpoint to get the list of images for a specific dog breed.
  static const String getImageList = "/images";

  /// Endpoint to get a random dog image.
  static const String getRandomImage = "/images/random";
}
