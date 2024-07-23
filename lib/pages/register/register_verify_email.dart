import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/generals/custom_button.dart';
import 'package:tepepixqui_movil/pages/login_page.dart';

class RegisterVerifyEmail extends StatelessWidget {
  final String correoElectronico;
  const RegisterVerifyEmail({super.key, required this.correoElectronico});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 250,
                height: 250,
              ),
              const SizedBox(height: 50),
              const Text(
                'Revisa tu correo electrónico',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                  children: [
                    const TextSpan(
                      text:
                          'Hemos enviado un enlace de verificación a tu correo electrónico. Por favor, verifica tu cuenta para continuar, lo hemos enviado al siguiente correo ',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    TextSpan(
                      text: correoElectronico,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "Volver al inicio de sesión",
                onPressed: () {
                  Get.offAll(
                      LoginPage()); // Navegar a la página de inicio de sesión
                },
                backgroundColor: Colors.black,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
