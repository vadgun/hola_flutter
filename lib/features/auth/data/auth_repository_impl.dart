import '../../../core/constants/endpoints.dart';
import '../../../core/network/api_client.dart';
import '../domain/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient apiClient;

  AuthRepositoryImpl(this.apiClient);

  @override
  Future<String> login(String username, String password) async {
    final response = await apiClient.post(
      Endpoints.baseUrl + Endpoints.login,
      {
        'username': username,
        'password': password,
      },
    );

    return response['token'];
  }
}
