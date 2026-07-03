import 'package:lesson1_5/domain/entity/auth_entity.dart';

class AuthModel extends AuthEntity{
  AuthModel({
    required super.token
  });
  factory AuthModel.fromJson(Map<String, dynamic> jason){
    return AuthModel(token: jason['token']);
  }
}