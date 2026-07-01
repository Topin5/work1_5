import 'package:dartz/dartz.dart';
import 'package:lesson1_5/core/failure.dart';
import 'package:lesson1_5/domain/entity/prodict_detail_entity.dart';
import 'package:lesson1_5/domain/entity/product_entity.dart';
import 'package:lesson1_5/domain/repo/product_repo.dart';

class GetAllProductsUsecase {
  final ProductRepo repo;
  GetAllProductsUsecase(this.repo, );

  Future<Either<Failure, List<ProductEntity>>> call(){
    return repo.getAllProducts();
  }

}

class GetAllDetailProductsUsecace{
  final ProductDetailRepo rep;
  GetAllDetailProductsUsecace(this.rep);

  Future<Either<Failure, List<ProductDetailEntity>>> call(int id){
    return rep.getAllDetailProducts(id);
  }
}

