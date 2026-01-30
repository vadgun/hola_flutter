import '../storage/token_storage.dart';

class AuthService {
  final TokenStorage _storage = TokenStorage();

  Future<bool> isLoggedIn() async {
    final token = await _storage.read();
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    await _storage.clear();
  }
}