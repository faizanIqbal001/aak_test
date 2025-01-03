import 'package:dartz/dartz.dart';
import 'package:aak_test/export.dart';

class AuthRepoImpl implements AuthRepo {
  final NetworkHelper networkHelper;

  AuthRepoImpl({
    required this.networkHelper,
  });

  @override
  Future<Either<String, GenericError>> signUpUser({
    required String userType,
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String password,
    required String country,
  }) async {
    final response = await networkHelper.post(NetworkEndPoints.signUp, body: {
      'user_type': userType,
      'first_name': firstName,
      'last_name': lastName,
      'username': userName,
      'email': email,
      'country': country,
      'password': password,
    });
    return response.fold(
      (success) {
        return left(
          '',
        );
      },
      (error) {
        return Right(
          GenericError(
            message: error.message,
            statusCode: error.statusCode,
          ),
        );
      },
    );
  }
}
