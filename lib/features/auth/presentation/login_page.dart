import 'package:flutter/material.dart';
import '../../../core/network/api_client.dart';
import '../data/auth_repository_impl.dart';
import 'login_controller.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late LoginController controller;

  @override
  void initState() {
    super.initState();

    usernameController = TextEditingController();
    passwordController = TextEditingController();

    controller = LoginController(AuthRepositoryImpl(ApiClient()));

    controller.addListener(() {
      if (controller.success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } else {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username:'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password:'),
            ),
            const SizedBox(height: 20),
            if (controller.error != null)
              Text(
                controller.error!,
                style: const TextStyle(color: Colors.red),
              ),
            ElevatedButton(
              onPressed: controller.loading
                  ? null
                  : () {
                      controller.login(
                        usernameController.text,
                        passwordController.text,
                      );
                    },
              child: controller.loading
                  ? const CircularProgressIndicator()
                  : const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
