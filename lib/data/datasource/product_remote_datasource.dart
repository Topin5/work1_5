
import 'package:dio/dio.dart';
import 'package:lesson1_5/data/model/product_model.dart';

abstract class ProductRemoteDatasource {
  Future<List<ProductModel>> getAllProducts();
}



class ProductRemoteDatasourceImpl implements ProductRemoteDatasource{
  
  final Dio dio;

  ProductRemoteDatasourceImpl(this.dio);
  
  @override
  Future<List<ProductModel>> getAllProducts()async{
    final response = await dio.get('https://fakestoreapi.com/products');
    return (response.data as List)
      .map((json) => ProductModel.fromJson(json))
      .toList();
  }

}

