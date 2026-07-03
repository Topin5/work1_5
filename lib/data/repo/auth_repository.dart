import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lesson1_5/core/failure.dart';
import 'package:lesson1_5/core/storage/secure_storage.dart';
import 'package:lesson1_5/data/datasource/auth_remote_datasourse.dart';
import 'package:lesson1_5/domain/entity/auth_entity.dart';
import 'package:lesson1_5/domain/entity/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasourse remoteDatasourse;
  final SecureStorage secureStorage;

  AuthRepositoryImpl({required this.remoteDatasourse, required this.secureStorage});

  @override
  Future<Either<Failure, AuthEntity>> login({
    required String username, 
    required String password}) async{
      try{
        final result = await remoteDatasourse.login(username: username, password: password);
        await secureStorage.saveToken(result.token);
        return Right(result);
      }on DioException catch (e){
        return Left(ServerFailure(e.message ?? 'ошибка соединение'));
      }catch (e){
        return Left(NetWorkFailure(e.toString()));
      }

  }

  @override
  Future<Either<Failure, void>> logout() async{
    try{
      await secureStorage.clearAll();
      return Right(null);
    }catch (e){
      return Left(ServerFailure('ошибка соединение'));
    }
  }
   
}