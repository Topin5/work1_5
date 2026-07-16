import 'package:dio/dio.dart';
import 'package:lesson1_5/data/model/product_model.dart';

class ProductResponse {
  final List<ProductModel> products;
  final int total;

  ProductResponse({required this.products, required this.total});
}

abstract class ProductRemoteDatasource {
  Future<ProductResponse> getAllProducts({
    required int page,
    int limit = 10
  }
  );
}

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource{
    final Dio dio;

  ProductRemoteDatasourceImpl(this.dio);
  
  @override
  Future<ProductResponse> getAllProducts({
    required int page,
    int limit = 10
  })async{
    final skip = page > 1?(page -1)* limit: 0;
    final response = await dio.get(
      '/products',
      queryParameters: {
        'limit':limit,
        'skip': skip
      }
      );
      final products = (response.data['products']as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();

        return ProductResponse(products: products, total: response.data['total']as int);
  }

}

