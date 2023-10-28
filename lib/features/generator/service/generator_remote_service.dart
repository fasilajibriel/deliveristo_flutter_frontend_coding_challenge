import 'package:dartz/dartz.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/constants/dio_api_constants.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/errors/api_failure.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/core/utils/typedef.dart';
import 'package:deliveristo_flutter_frontend_coding_challenge/features/generator/data/breed/dog_breed_model.dart';
import 'package:dio/dio.dart';

/// A class for performing remote services related to dog breed generation.
///
/// The `GeneratorRemoteService` class provides methods for making network
/// requests to generate dog breeds. It utilizes the Dio HTTP client for
/// sending and handling network requests.
class GeneratorRemoteService {
  /// The base options for network requests, including timeouts and error
  /// handling.
  static final BaseOptions baseOptions = BaseOptions(
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  );

  /// The Dio HTTP client for making network requests.
  static final Dio dio = Dio();

  /// Fetches a list of dog breeds from a remote server.
  ///
  /// This method sends an HTTP GET request to retrieve a list of dog breeds
  /// from a remote server. It uses the Dio client and the provided
  /// [baseOptions] for making the request.
  ///
  /// Returns a [FutureResult] containing a [DogBreedModel] on success or an
  /// [ApiFailure] on failure.
  static FutureResult<DogBreedModel> getDogBreeds() async {
    try {
      final Response<dynamic> response = await dio.get(
        DioApiConstants.breedList,
      );

      final DogBreedModel dogBreeds = DogBreedModel.fromMap(
        response.data as Map<String, dynamic>,
      );

      return Right(dogBreeds);
    } on DioException catch (e) {
      return Left(
        ApiFailure(
          message: e.message ?? "",
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
          statusCode: 500,
        ),
      );
    }
  }
}
