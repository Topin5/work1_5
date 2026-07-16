import 'package:dio/dio.dart';
import 'package:lesson1_5/data/model/auth_model.dart';

abstract class AuthRemoteDatasourse {
  Future<AuthModel> login({
    required String username,
    required String password
  });
}

class AuthRemoteDatasourseIml implements AuthRemoteDatasourse{
  final Dio dio;
  AuthRemoteDatasourseIml(this.dio);
  @override
  Future<AuthModel> login({
    required String username, 
    required String password})async {
      final response = await dio.post(
        '/auth/login',
        data: {
          'username': username,
          'password': password
        }
     );
     print(username);
     print(password);
     return AuthModel.fromJson(response.data); 
  }

}