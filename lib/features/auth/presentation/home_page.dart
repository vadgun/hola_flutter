import 'package:flutter/material.dart';
import 'package:hola_flutter/features/auth/presentation/login_page.dart';
import 'package:hola_flutter/features/auth/data/auth_repository_impl.dart';
import 'package:hola_flutter/core/network/api_client.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async  {
              final repository = AuthRepositoryImpl(ApiClient());
              await repository.logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false, // 👈 elimina historial
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Bienvenido 👋',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
