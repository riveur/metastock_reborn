import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String _authUrl =
      "https://metastock.alexandre.re:8443/realms/metastock/protocol/openid-connect/token";
  final String _grantType = "password";
  final String _clientId = "api";
  final String _clientSecret = "MYyFte3ix2fjIyIv9XaN4CoO3oAQlD5x";
  final String _scope = "openid";
  static const tokenKey = "bearer_token";

  final dio = Dio();
  final storage = const FlutterSecureStorage();

  Future<bool> login(String username, String password) async {
    try {
      final response = await dio.post(_authUrl,
          data: {
            "grant_type": _grantType,
            "client_id": _clientId,
            "client_secret": _clientSecret,
            "scope": _scope,
            "username": username,
            "password": password
          },
          options: Options(headers: {
            Headers.contentTypeHeader: "application/x-www-form-urlencoded",
            Headers.acceptHeader: "application/json"
          }));

      await storage.write(key: tokenKey, value: response.data["access_token"]);

      return true;
    } on DioException {
      return false;
    }
  }

  Future<bool> logout() async {
    await storage.delete(key: tokenKey);
    return true;
  }
}
