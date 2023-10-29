/// An extension for string manipulation in Dart.
///
/// The `StringExtension` extension provides useful methods for working with
/// strings in Dart.
extension StringExtension on String {
  /// Capitalizes the first letter of the string.
  ///
  /// This method returns a new string with the first letter capitalized and the
  /// rest of the string in lowercase.
  String capitalizeFirstLetter() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
