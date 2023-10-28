import 'package:dartz/dartz.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/errors/faliure.dart';

/// A function signature for representing asynchronous operations that return a
/// result of type `T` or an error of type `Failure`.
///
/// A `FutureResult` represents an asynchronous operation that may return a
/// value of type `T` when successful, or a `Failure` object when an error
/// occurs. This allows for safer error handling in asynchronous code by using
/// the `Either` type from the Dartz library, where `Right` indicates success
/// and `Left` represents a failure.
typedef FutureResult<T> = Future<Either<Faliure, T>>;

/// A function signature for representing asynchronous operations that return no
/// value or an error of type `Failure`.
///
/// A `FutureVoid` represents an asynchronous operation that may not return any
/// value and instead indicates success or failure using the `Failure` type.
/// It's suitable for cases where the operation's success is the absence of an
/// error.
typedef FutureVoid<T> = FutureResult<void>;
