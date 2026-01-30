import 'dart:convert';
import 'package:http/http.dart' as http;
import '../storage/token_storage.dart';
import '../auth/auth_service.dart';
import 'api_exceptions.dart';

class ApiClient {
  final TokenStorage _tokenStorage = TokenStorage();
  final AuthService _authService = AuthService();

  Future<Map<String, dynamic>> post(
    String url,
    Map<String, dynamic> body,
  ) async {
    final token = await _tokenStorage.read();

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json', if (token != null) 'Authorization': 'Bearer $token'},
      body: jsonEncode(body),
    );

    // 🔥 INTERCEPTOR 401
    if (response.statusCode == 401) {
      await _authService.logout();
      throw UnauthorizedException();
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(response.body);
    }

    return jsonDecode(response.body);
  }
}
