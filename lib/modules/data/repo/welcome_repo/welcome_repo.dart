import 'package:dartz/dartz.dart';

abstract class WelcomeRepo {
  Future<Either<String, String>> signUpUser();
}
