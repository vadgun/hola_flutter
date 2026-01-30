import 'package:flutter/material.dart';
import '../core/auth/auth_service.dart';
import '../features/auth/presentation/login_page.dart';
import '../features/home/presentation/home_page.dart';

class AppEntry extends StatelessWidget {
  const AppEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: AuthService().isLoggedIn(),
      builder: (context, snapshot) {
        // Mientras se revisa el token
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Si hay token → Home
        if (snapshot.data == true) {
          return const HomePage();
        }

        // Si no → Login
        return const LoginPage();
      },
    );
  }
}
