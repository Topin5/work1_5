import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lesson1_5/data/datasource/detail_product_remote_datasource.dart';
import 'package:lesson1_5/data/datasource/product_remote_datasource.dart';
import 'package:lesson1_5/data/repo/detail_product_repository.dart';
import 'package:lesson1_5/data/repo/product_repository.dart';
import 'package:lesson1_5/domain/repo/product_repo.dart';
import 'package:lesson1_5/domain/usecase/get_all_products_usecase.dart';

final sl = GetIt.instance;

void init(){
  sl.registerFactory(() => GetAllProductsUsecase(sl()));

  sl.registerLazySingleton<ProductRepo>(()   => ProductRepositoryImpl(sl()));

  sl.registerLazySingleton(() => ProductRemoteDatasourceImpl(sl()));

  sl.registerLazySingleton(() => Dio());

  sl.registerFactory(() => GetAllDetailProductsUsecace(sl()));

  sl.registerLazySingleton<ProductDetailRepo>(() => DetailProductRepository(sl()));

  sl.registerLazySingleton(()=> ProductDetailRemoteDatasourceImpl(sl()));

}


