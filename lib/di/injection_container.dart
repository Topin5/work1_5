import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lesson1_5/core/network/api_client.dart';
import 'package:lesson1_5/core/storage/secure_storage.dart';
import 'package:lesson1_5/data/datasource/auth_remote_datasourse.dart';
import 'package:lesson1_5/data/datasource/detail_product_remote_datasource.dart';
import 'package:lesson1_5/data/datasource/product_remote_datasource.dart';
import 'package:lesson1_5/data/repo/auth_repository.dart';
import 'package:lesson1_5/data/repo/detail_product_repository.dart';
import 'package:lesson1_5/data/repo/product_repository.dart';
import 'package:lesson1_5/domain/entity/auth_repository.dart';
import 'package:lesson1_5/domain/repo/product_repo.dart';
import 'package:lesson1_5/domain/usecase/get_all_products_usecase.dart';
import 'package:lesson1_5/domain/usecase/login_usecase.dart';
import 'package:lesson1_5/domain/usecase/logout_usecace.dart';
import 'package:lesson1_5/ui/bloc/cart_bloc.dart';
import 'package:lesson1_5/ui/bloc/detail_product_bloc.dart';
import 'package:lesson1_5/ui/bloc/product_bloc.dart';

final sl = GetIt.instance;

void init(){

  sl.registerFactory(() => ProductBloc(sl()));

  sl.registerFactory(()=> DetailProductBloc(sl()));

  sl.registerLazySingleton(()=> CartBloc());

  sl.registerLazySingleton(() => GetAllProductsUsecase(sl()));
  sl.registerLazySingleton(()=> LoginUsecase(sl()));
  sl.registerLazySingleton(()=> LogoutUsecace(sl()));

  sl.registerLazySingleton<ProductRepo>(() => ProductRepositoryImpl(sl()));

  sl.registerLazySingleton(() => ApiClient(sl()));
  sl.registerLazySingleton(()=> SecureStorage());

  sl.registerLazySingleton<ProductRemoteDatasource>(() => 
  ProductRemoteDatasourceImpl(sl<ApiClient>().dio));

  sl.registerLazySingleton<AuthRepository>(()=>
  AuthRepositoryImpl(remoteDatasourse: sl(), secureStorage: sl()));


  sl.registerLazySingleton<AuthRemoteDatasourse>(()=>
  AuthRemoteDatasourseIml(sl<ApiClient>().dio));

  sl.registerLazySingleton(() => Dio());

  sl.registerLazySingleton(() => GetAllDetailProductsUsecace(sl()));

  sl.registerLazySingleton<ProductDetailRepo>(() => DetailProductRepository(sl()));

  sl.registerLazySingleton<ProductDetailRemoteDatasource>(
  () => ProductDetailRemoteDatasourceImpl(sl<ApiClient>().dio)
);
}


