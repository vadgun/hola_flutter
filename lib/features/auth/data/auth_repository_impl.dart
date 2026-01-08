import '../../../core/constants/endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../../core/storage/token_storage.dart';
import '../domain/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient apiClient;
  final TokenStorage tokenStorage = TokenStorage();

  AuthRepositoryImpl(this.apiClient);

  @override
  Future<String> login(String username, String password) async {
    final response = await apiClient.post(Endpoints.baseUrl + Endpoints.login, {
      'username': username,
      'password': password,
    });

    final token = response['token'];
    await tokenStorage.save(token);

    return response['token'];
  }

  @override
  Future<void> logout() async {
    await tokenStorage.clear();
  }
}
