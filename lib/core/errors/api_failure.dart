import 'package:deliveristo_flutter_frontend_coding_challenge/core/errors/faliure.dart';

class ApiFailure extends Faliure {
  const ApiFailure({
    required super.message,
    super.statusCode,
  });
}
