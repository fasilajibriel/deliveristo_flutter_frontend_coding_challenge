import 'package:dartz/dartz.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/errors/faliure.dart';

typedef FutureResult<T> = Future<Either<Faliure, T>>;
typedef FutureVoid<T> = FutureResult<void>;
