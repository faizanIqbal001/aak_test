import 'package:dartz/dartz.dart';
import 'package:aak_test/export.dart';

class WelcomeRepoImpl implements WelcomeRepo {
  final NetworkHelper networkHelper;

  WelcomeRepoImpl({
    required this.networkHelper,
  });

  @override
  Future<Either<String, String>> signUpUser() async {
    final response = await networkHelper.get(
      NetworkEndPoints.signUp,
    );
    return response.fold(
      (success) {
        return left(
          '',
        );
      },
      (error) {
        return const Right(
          'Error',
        );
      },
    );
  }
}
