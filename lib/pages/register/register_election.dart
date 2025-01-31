import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/generals/custom_button_circular.dart';
import 'package:tepepixqui_movil/components/generals/theme_switcher.dart';
import 'package:tepepixqui_movil/controllers/navigation/theme_controller.dart';
import 'package:tepepixqui_movil/pages/login_page.dart';
import 'package:tepepixqui_movil/pages/register/register_ong_form1.dart';
import 'package:tepepixqui_movil/pages/register/register_volunteer_election.dart';

class RegisterElection extends StatelessWidget {
  RegisterElection({super.key});

  final ThemeController themeController = Get.find<ThemeController>();
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
                  const SizedBox(height: 40),
                  Image.asset(
                    'assets/images/logo.png',
                    width: 250,
                    height: 250,
                  ),
                  const SizedBox(height: 50),
                   Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularButton(
              icon: Icons.people,
              text: 'Si eres voluntario,\npulsa aquí',
              onPressed: () {
                Get.to(RegisterVolunteerElection());
              },
              heroTag: 'voluntarioHeroTag',
              size: 140.0, // Tamaño personalizado
              backgroundColor: Colors.blue, // Color personalizado
              foregroundColor: Colors.white, // Color de texto personalizado
            ),
            CircularButton(
              icon: Icons.apartment,
              text: 'Si eres una ONG,\npulsa aquí',
              onPressed: () {
                Get.to(RegisterOngForm1());
              },
              heroTag: 'ongHeroTag',
              size: 140.0, // Tamaño personalizado
              backgroundColor: Colors.green, // Color personalizado
              foregroundColor: Colors.white, // Color de texto personalizado
            ),
          ],
        ),

                  const SizedBox(height: 100),
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
