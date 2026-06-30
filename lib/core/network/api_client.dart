import 'package:dio/dio.dart';

class ApiClient {
  late final Dio dio;
  ApiClient(){
    dio = Dio(BaseOptions(
      baseUrl: '',
      connectTimeout: const Duration(seconds: 3),
      receiveTimeout: const Duration(seconds: 3),
      headers: {'Content_Type': 'application/json'}
    ));

    dio.interceptors.addAll([
      _LoggingInterceptor(),
      _ErrorInterceptor()
    ]);
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