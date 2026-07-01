import 'package:dartz/dartz.dart';
import 'package:lesson1_5/core/failure.dart';
import 'package:lesson1_5/domain/entity/prodict_detail_entity.dart';
import 'package:lesson1_5/domain/entity/product_entity.dart';

abstract class ProductRepo {
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
}

abstract class ProductDetailRepo{
  Future<Either<Failure, List<ProductDetailEntity>>>  getAllDetailProducts(int id);
}