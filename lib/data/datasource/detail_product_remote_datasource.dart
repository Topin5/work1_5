import 'package:dio/dio.dart';
import 'package:lesson1_5/data/model/product_detail_model.dart';

abstract class ProductDetailRemoteDatasource{
  Future<List<ProductDetailModel>> getAllDetailProducts();
}
class ProductDetailRemoteDatasourceImpl implements ProductDetailRemoteDatasource{
  final Dio dio;
  ProductDetailRemoteDatasourceImpl(this.dio);
  
  @override
  Future<List<ProductDetailModel>> getAllDetailProducts()async {
    final response = await dio.get('https://fakestoreapi.com/products');
    return (response.data as List)
      .map((json) => ProductDetailModel.fromJson(json))
      .toList();
  }  
}