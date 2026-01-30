import 'package:flutter/material.dart';
import 'client_controller.dart';

class CreateClientPage extends StatefulWidget {
  const CreateClientPage({super.key});

  @override
  State<CreateClientPage> createState() => _CreateClientPageState();
}

class _CreateClientPageState extends State<CreateClientPage> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late ClientController controller;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    controller = ClientController();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alta de cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Teléfono'),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Dirección'),
            ),
            const SizedBox(height: 20),

            if (controller.error != null)
              Text(
                controller.error!,
                style: const TextStyle(color: Colors.red),
              ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: controller.loading
                  ? null
                  : () async {
                      await controller.saveClient(
                        name: nameController.text,
                        phone: phoneController.text,
                        address: addressController.text,
                      );

                      if (controller.error == null) {
                        Navigator.pop(context); // volver a Home
                      }
                    },
              child: controller.loading
                  ? const CircularProgressIndicator()
                  : const Text('Guardar cliente'),
            ),
          ],
        ),
      ),
    );
  }
}
