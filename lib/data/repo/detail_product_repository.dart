import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lesson1_5/core/failure.dart';
import 'package:lesson1_5/data/datasource/detail_product_remote_datasource.dart';
import 'package:lesson1_5/domain/entity/prodict_detail_entity.dart';
import 'package:lesson1_5/domain/repo/product_repo.dart';

class DetailProductRepository implements ProductDetailRepo{
  final ProductDetailRemoteDatasource remoteDetailDatasource;

  DetailProductRepository(this.remoteDetailDatasource);

  @override
  Future<Either<Failure, List<ProductDetailEntity>>> getAllDetailProducts()async{
    try{final deatailProducts = await remoteDetailDatasource.getAllDetailProducts();
      return Right(deatailProducts);
    }on DioException catch(e){
      return Left(ServerFailure(e.message ?? 'ошибка соединение'));
    }catch(e){
      return Left(NetWorkFailure('нет соединение'));
    }
  }
}