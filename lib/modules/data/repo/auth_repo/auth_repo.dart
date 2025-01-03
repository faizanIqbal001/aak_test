import 'package:aak_test/export.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<String, GenericError>> signUpUser({
    required String userType,
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String password,
    required String country,
  });
}
