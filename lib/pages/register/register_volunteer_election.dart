import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/custom_button.dart';
import 'package:tepepixqui_movil/controllers/register/register_volunteer_controller.dart';
import 'package:tepepixqui_movil/pages/login_page.dart';
import 'package:tepepixqui_movil/pages/register/register_volunteer_form.dart';

class RegisterVolunteerElection extends StatelessWidget {
  const RegisterVolunteerElection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterVolunteerController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                Image.asset(
                  'assets/images/logo.png',
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 100),
                ListTile(
                  leading: Image.asset(
                    'assets/images/google.png',
                    width: 24,
                    height: 24,
                  ),
                  title: CustomButton(
                    text: "Registrarse con Google",
                    onPressed: () => controller.signUpWithGoogle(),
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: CustomButton(
                    text: "Registrarse con Formulario",
                    onPressed: () => Get.to(RegisterVolunteerForm()),
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Ya tienes cuenta?",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAll(LoginPage());
                      },
                      child: const Text(
                        " Inicia sesión aquí",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
