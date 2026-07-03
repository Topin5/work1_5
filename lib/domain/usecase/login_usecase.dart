import 'package:dartz/dartz.dart';
import 'package:lesson1_5/core/failure.dart';
import 'package:lesson1_5/domain/entity/auth_entity.dart';
import 'package:lesson1_5/domain/entity/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repo;

  LoginUsecase(this.repo);

  Future<Either<Failure, AuthEntity>> call({
    required String username,
    required String password
  }){
    return repo.login(username: username, password: password);
  }
}