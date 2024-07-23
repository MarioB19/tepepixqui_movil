import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/controllers/auth_controller.dart';

class IndexOng extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  IndexOng({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenida ONG'),
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
          'Hola, soy ong ${authController.getUid()}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
