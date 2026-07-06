import 'package:dio/dio.dart';
import 'package:lesson1_5/core/storage/secure_storage.dart';

class ApiClient {
  late final Dio dio;
  final SecureStorage secureStorage;
  ApiClient(this.secureStorage){
    dio = Dio(BaseOptions(
      baseUrl: 'https://fakestoreapi.com/',
      connectTimeout: const Duration(seconds: 3),
      receiveTimeout: const Duration(seconds: 3),
      headers: {'Content_Type': 'application/json'}
    ));

    dio.interceptors.addAll([
      _LoggingInterceptor(),
      _ErrorInterceptor(),
      _AuthInterceptor(secureStorage)
    ]);
  }
}

class _AuthInterceptor extends Interceptor {
  final SecureStorage secureStorage;
  _AuthInterceptor(this.secureStorage);

  @override
   void onRequest (RequestOptions options, RequestInterceptorHandler handler)async{
    final token = await secureStorage.getToken();
    if(token != null){
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
   }
   
   @override
  void onError(DioException err, ErrorInterceptorHandler handler){
    if(err.response?.statusCode == 401){
      secureStorage.clearAll();
    }
    handler.next(err);
  }
}

class _LoggingInterceptor extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('->${options.method} ${options.path}');
 handler.next(options);  
}

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    print('<- ${response.statusCode} ${response.data}');
  handler.next(response);  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('x ${err.response?.statusCode} ${err.message}');
  handler.next(err); 
 }
}

class _ErrorInterceptor extends Interceptor{
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if(err.response?.statusCode == 401){
      print('Сессия истекла');
    }
    super.onError(err, handler);
  }
}