import 'package:deliveristo_flutter_frontend_coding_challenge/features/onboarding/data/user/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A utility class for handling local storage operations related to onboarding
/// and user data.
///
/// The `OnboardingLocalService` class provides static methods to read and write
/// specific data to the device's shared preferences. It is commonly used to
/// manage settings or data that need to persist between app sessions.
class OnboardingLocalService {
  /// Writes a boolean flag to indicate whether it's the user's first time using
  /// the app.
  ///
  /// The [isFirstTime] parameter represents a boolean value to indicate whether
  /// it's the user's first-time experience with the app. It is stored in shared
  /// preferences under the key "firstTime".
  ///
  /// Returns `true` when the data is successfully written, and `false` on
  /// failure.
  static Future<bool> writeIsFirstBool({required bool isFirstTime}) async {
    const String key = "firstTime";
    final SharedPreferences preferenceInstance =
        await SharedPreferences.getInstance();

    return preferenceInstance.setBool(key, isFirstTime);
  }

  /// Reads the first-time flag from shared preferences.
  ///
  /// This method checks if the "firstTime" flag exists in shared preferences
  /// and whether it's set to `true`, indicating it's the user's first time
  /// using the app.
  ///
  /// Returns `true` if it's the user's first time, or `false` if the flag is
  /// not set or set to `false`.
  static Future<bool> readIsFirstBool() async {
    const String key = "firstTime";
    final SharedPreferences preferenceInstance =
        await SharedPreferences.getInstance();

    if (preferenceInstance.containsKey(key)) {
      return preferenceInstance.getBool(key)!;
    }

    return true;
  }

  /// Writes a user object to local storage.
  ///
  /// The [user] parameter represents a `UserModel` object that will be stored
  /// in shared preferences under the key "user" in JSON format.
  ///
  /// Returns `true` when the user data is successfully written, and `false` on
  /// failure.
  static Future<bool> writeUserObject({required UserModel user}) async {
    const String key = "user";
    final SharedPreferences preferenceInstance =
        await SharedPreferences.getInstance();

    return preferenceInstance.setString(key, user.toJson());
  }

  /// Reads a user object from local storage.
  ///
  /// This method retrieves a `UserModel` object from shared preferences under
  /// the key "user" and deserializes it from JSON format. If the key doesn't
  /// exist or data is corrupt, a default empty `UserModel` is returned.
  ///
  /// Returns the stored `UserModel` or an empty `UserModel` object.
  static Future<UserModel> readUserObject() async {
    const String key = "user";
    final SharedPreferences preferenceInstance =
        await SharedPreferences.getInstance();
    final userJson = preferenceInstance.getString(key);

    return userJson != null
        ? UserModel.fromJson(userJson)
        : const UserModel.empty();
  }
}
