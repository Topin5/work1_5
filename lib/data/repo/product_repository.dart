import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lesson1_5/core/failure.dart';
import 'package:lesson1_5/data/datasource/product_remote_datasource.dart';
import 'package:lesson1_5/domain/entity/pagin_result.dart';
import 'package:lesson1_5/domain/entity/product_entity.dart';
import 'package:lesson1_5/domain/repo/product_repo.dart';

class ProductRepositoryImpl implements ProductRepo {
 
  final ProductRemoteDatasource remoteDatasource;

  ProductRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, PaginResult<ProductEntity>>> getAllProducts({
    required int page,
    int limit =10
  })async {
    try{
      final response = await remoteDatasource.getAllProducts(
        page: page,
        limit: limit
      );
      final skip = (page - 1)* limit;
      return Right(PaginResult(
        items: response.products,
        currentPage: page, 
        hasnextPage: skip + response.products.length < response.total));
    }on DioException catch (e){
      return Left(ServerFailure (e.message ?? 'Ошибка сервера'));
    } catch(e){
      return Left(NetWorkFailure (e.toString()));
    }
  }
  
}


