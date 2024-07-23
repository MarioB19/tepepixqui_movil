import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/generals/custom_button.dart';
import 'package:tepepixqui_movil/components/generals/custom_button_google.dart';
import 'package:tepepixqui_movil/components/generals/custom_text_field.dart';
import 'package:tepepixqui_movil/controllers/login_controller.dart';
import 'package:tepepixqui_movil/pages/register/forgot_password_page.dart';
import 'package:tepepixqui_movil/pages/register/register_election.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/logo.png',
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  hintText: "Nombre de Usuario o Correo electrónico",
                  controller: loginController.usernameOrCorreoController,
                  isPassword: false,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 10),
                Obx(() {
                  return CustomTextField(
                    hintText: "Contraseña",
                    controller: loginController.passwordController,
                    isPassword: true,
                    isPasswordVisible: loginController.isPasswordVisible.value,
                    onVisibilityToggle: () {
                      loginController.togglePasswordVisibility();
                    },
                    onChanged: (value) {},
                  );
                }),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(ForgotPasswordPage());
                      },
                      child: const Text(
                        "¿Olvidaste tu contraseña?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                CustomButton(
                  text: "Iniciar Sesión",
                  onPressed: () => 
                     loginController.login()
                  ,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 50),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'o continuar con',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButtonGoogle(imagePath: 'assets/images/google.png'),
                    SizedBox(width: 25),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("¿Aún no tienes cuenta? ",
                        style: TextStyle(color: Colors.black)),
                    GestureDetector(
                      onTap: () => Get.to(const RegisterElection()),
                      child: const Text(
                        "Regístrate Aquí",
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
