/// Constants for Firebase API related settings.
///
/// The [FirebaseApiConstants] class defines constant values used for Firebase
/// API configuration and collections. It includes constants for the user's
/// collection and a saved collection, which can be utilized for organizing
/// data within Firebase Firestore.
class FirebaseApiConstants {
  /// Collection name for user-related data.
  static const String usersCollection = "users";

  /// Collection name for saved data associated with users.
  static const String usersSavedCollection = "saved";
}
