import 'package:deliveristo_flutter_frontend_coding_challenge/core/errors/faliure.dart';

/// Represents a failure in the API communication.
///
/// The [ApiFailure] class is a specific type of failure that occurs during API
/// communication. It extends the more general [Faliure] class and provides
/// additional details, including an error message and an optional status code.
class ApiFailure extends Faliure {
  /// Creates an [ApiFailure] with the specified error [message] and optional
  /// [statusCode].
  const ApiFailure({
    required super.message,
    super.statusCode,
  });
}
