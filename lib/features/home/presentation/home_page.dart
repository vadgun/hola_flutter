import 'package:flutter/material.dart';
import 'package:hola_flutter/features/auth/presentation/login_page.dart';
import 'package:hola_flutter/features/auth/data/auth_repository_impl.dart';
import 'package:hola_flutter/core/auth/auth_service.dart';
import 'package:hola_flutter/core/network/api_client.dart';
import 'package:hola_flutter/features/clients/presentation/create_client_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _checkAuth(BuildContext context) async {
    final isLoggedIn = await AuthService().isLoggedIn();
    if (!isLoggedIn) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkAuth(context); // 👈 Auth Guard

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final repository = AuthRepositoryImpl(ApiClient());
              await repository.logout();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (_) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Te amo colochita ❤️',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 30),

            // 👉 Alta cliente
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CreateClientPage(),
                  ),
                );
              },
              child: const Text('Alta cliente'),
            ),

            const SizedBox(height: 12),

            // 👉 Crear gasto (pendiente)
            ElevatedButton(
              onPressed: null,
              child: const Text('Crear gasto'),
            ),

            const SizedBox(height: 12),

            // 👉 Crear venta (pendiente)
            ElevatedButton(
              onPressed: null,
              child: const Text('Crear venta'),
            ),
          ],
        ),
      ),
    );
  }
}

