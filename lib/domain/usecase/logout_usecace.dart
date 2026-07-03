import 'package:dartz/dartz.dart';
import 'package:lesson1_5/core/failure.dart';
import 'package:lesson1_5/domain/entity/auth_repository.dart';

class LogoutUsecace {
  final AuthRepository repo;
  LogoutUsecace(this.repo);

  Future<Either<Failure, void>> call(){
    return repo.logout();
  }
}