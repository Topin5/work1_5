import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage{
  final _storage = const FlutterSecureStorage ();

    static const _tokenKey = 'auth_token';
    
    Future<void> saveToken(String token){
      return _storage.write(key: _tokenKey, value: token);

      
    }

    Future<String?> getToken() => 
      _storage.read(key: _tokenKey);
  
    Future<bool> get isLoggedIn async{
      final token = await getToken();
      return token != null && token.isNotEmpty;
    }

    Future<void> clearAll() => _storage.deleteAll();
}