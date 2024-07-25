import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/generals/custom_button.dart';
import 'package:tepepixqui_movil/components/generals/custom_dialog.dart';
import 'package:tepepixqui_movil/components/generals/theme_switcher.dart';
import 'package:tepepixqui_movil/controllers/navigation/theme_controller.dart';
import 'package:tepepixqui_movil/controllers/register/register_volunteer_controller.dart';
import 'package:tepepixqui_movil/pages/login_page.dart';
import 'package:tepepixqui_movil/pages/register/register_volunteer_form.dart';

class RegisterVolunteerElection extends StatelessWidget {
  RegisterVolunteerElection({super.key});
  final ThemeController themeController = Get.find<ThemeController>();
  final controller = Get.put(RegisterVolunteerController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          actions: [ThemeSwitcher()],
          backgroundColor: themeController.appBarLogin(),
        ),
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
                      onPressed: () => {CustomDialogController.showCustomDialog("Esto no esta funcionando")},
                      backgroundColor: Colors.green,
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
    });
  }
}
