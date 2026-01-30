import 'package:flutter/material.dart';

class ClientController extends ChangeNotifier {
  bool loading = false;
  String? error;

  Future<void> saveClient({
    required String name,
    required String phone,
    required String address,
  }) async {
    if (name.isEmpty || phone.isEmpty) {
      error = 'Nombre y teléfono son obligatorios';
      notifyListeners();
      return;
    }

    loading = true;
    error = null;
    notifyListeners();

    // 🔧 Simulación de guardado (API después)
    await Future.delayed(const Duration(seconds: 1));

    loading = false;
    notifyListeners();
  }
}
