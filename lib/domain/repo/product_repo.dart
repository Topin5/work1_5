import 'package:dartz/dartz.dart';
import 'package:lesson1_5/core/failure.dart';
import 'package:lesson1_5/domain/entity/pagin_result.dart';
import 'package:lesson1_5/domain/entity/prodict_detail_entity.dart';
import 'package:lesson1_5/domain/entity/product_entity.dart';

abstract class ProductRepo {
  Future<Either<Failure, PaginResult<ProductEntity>>> getAllProducts(
    {
    required int page,
    int limit = 10
    }
  );
}

abstract class ProductDetailRepo{
  Future<Either<Failure, List<ProductDetailEntity>>>  getAllDetailProducts(int id);
}