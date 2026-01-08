import 'package:flutter/material.dart';
import '../domain/auth_repository.dart';

class LoginController extends ChangeNotifier {
  final AuthRepository repository;

  bool loading = false;
  String? error;
  bool success = false;

  LoginController(this.repository);

  Future<void> login(String username, String password) async {
    loading = true;
    error = null;
    success = false;
    notifyListeners();

    try {
      await repository.login(username, password);
      success = true; // 👈 LOGIN OK
    } catch (e) {
      error = 'Credenciales inválidas';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await repository.logout();
    success = false;
    notifyListeners();
  }
}
