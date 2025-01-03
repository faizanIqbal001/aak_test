import 'package:aak_test/export.dart';
import 'package:dartz/dartz.dart';

class AuthUseCase {
  final AuthRepo authRepo;

  AuthUseCase({required this.authRepo});

  Future<Either<String, GenericError>> signUpUser({
    required String userType,
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String password,
    required String country,
  }) async {
    final response = await authRepo.signUpUser(
      userType: userType,
      firstName: firstName,
      lastName: lastName,
      userName: userName,
      email: email,
      password: password,
      country: country,
    );
    return response.fold(
      (success) {
        return left(
          success,
        );
      },
      (error) {
        return Right(
          error,
        );
      },
    );
  }
}
