import 'package:dartz/dartz.dart';
import 'package:lesson1_5/core/failure.dart';
import 'package:lesson1_5/domain/entity/auth_entity.dart';

abstract class AuthRepository {

  Future<Either<Failure, AuthEntity>> login({
    required String username,
    required String password
  });

  Future<Either<Failure, void>> logout();
}