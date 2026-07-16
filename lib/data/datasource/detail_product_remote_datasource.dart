import 'package:dio/dio.dart';
import 'package:lesson1_5/data/model/product_detail_model.dart';

abstract class ProductDetailRemoteDatasource{
  Future<List<ProductDetailModel>> getAllDetailProducts(int id);
}
class ProductDetailRemoteDatasourceImpl implements ProductDetailRemoteDatasource{
  final Dio dio;
  ProductDetailRemoteDatasourceImpl(this.dio);
  
  @override
  Future<List<ProductDetailModel>> getAllDetailProducts(int id)async {
    final response = await dio.get('https://dummyjson.com/products/$id');
    return [ProductDetailModel.fromJson(response.data)];
  }  
}