import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/controllers/auth_controller.dart';

class IndexVolunteer extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  IndexVolunteer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido Voluntario'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authController.logout();
            },
          ),
        ],
      ),
      body:  Center(
        child: Text(
          'Hola, soy voluntario ${authController.getUid()}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
