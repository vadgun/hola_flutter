import 'package:flutter/material.dart';
import '../domain/auth_repository.dart';

class LoginController extends ChangeNotifier {
  final AuthRepository repository;

  bool loading = false;
  String? error;

  LoginController(this.repository);

  Future<void> login(String username, String password) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      await repository.login(username, password);
    } catch (e) {
      error = 'Credenciales inválidas';
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
