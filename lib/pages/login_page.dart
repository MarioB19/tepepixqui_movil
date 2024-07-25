import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/generals/custom_button.dart';
import 'package:tepepixqui_movil/components/generals/custom_button_google.dart';
import 'package:tepepixqui_movil/components/generals/custom_text_field.dart';
import 'package:tepepixqui_movil/components/generals/theme_switcher.dart';
import 'package:tepepixqui_movil/controllers/login_controller.dart';
import 'package:tepepixqui_movil/controllers/navigation/theme_controller.dart';
import 'package:tepepixqui_movil/pages/register/forgot_password_page.dart';
import 'package:tepepixqui_movil/pages/register/register_election.dart';
import 'package:tepepixqui_movil/utils/validations/login/validations_volunteer.dart';

class LoginPage extends StatelessWidget {
  final ThemeController themeController = Get.find<ThemeController>();
    final LoginController loginController = Get.put(LoginController());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          actions: [ThemeSwitcher()],
          backgroundColor: themeController.appBarLogin(),
        ),
        body: Form(
          key: loginController.loginFormKey.value,
          child: SingleChildScrollView(
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
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return "El campo no puede ser vacio";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Obx(() {
                      return CustomTextField(
                        hintText: "Contraseña",
                        controller: loginController.passwordController,
                        onChanged: (value) {},
                        isPassword: true,
                        isPasswordVisible: loginController.isPasswordVisible.value,
                        onVisibilityToggle: loginController.togglePasswordVisibility,
                        keyboardType: TextInputType.text,
                        validator: (value) => ValidationsVolunteer.validarContrasena(value),
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
                      onPressed: () => loginController.login(),
                    ),
                    const SizedBox(height: 50),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'o continuar con',
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1,
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
                        const Text(
                          "¿Aún no tienes cuenta? ",
                        ),
                        GestureDetector(
                          onTap: () => Get.to(RegisterElection()),
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
        ),
      );
    });
  }
}
