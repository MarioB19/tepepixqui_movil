import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/controllers/auth_controller.dart';

class ErrorPage extends StatelessWidget {


   final AuthController controller = Get.find<AuthController>();

   ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
        backgroundColor: Colors.red, 
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'lib/images/error.png', 
                width: 200,
              ),
              const SizedBox(height: 30),
              const Text(
                "Algo salió mal. Por favor, intenta nuevamente.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'No te preocupes, estas cosas pasan. Vamos a solucionarlo.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  controller.logout();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, 
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text('Volver atrás'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}