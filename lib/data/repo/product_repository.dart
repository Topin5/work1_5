import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lesson1_5/core/failure.dart';
import 'package:lesson1_5/data/datasource/product_remote_datasource.dart';
import 'package:lesson1_5/domain/entity/product_entity.dart';
import 'package:lesson1_5/domain/repo/product_repo.dart';

class ProductRepositoryImpl implements ProductRepo {
 
  final ProductRemoteDatasource remoteDatasource;

  ProductRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts()async {
    try{
      final products = await remoteDatasource.getAllProducts();
      return Right(products);
    }on DioException catch (e){
      return Left(ServerFailure (e.message ?? 'Ошибка сервера'));
    }catch(e){
      return Left(NetWorkFailure ('нет соединение'));
    }
  }
  
}


