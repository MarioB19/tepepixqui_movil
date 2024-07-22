import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/custom_button_circular.dart';
import 'package:tepepixqui_movil/pages/login_page.dart';
import 'package:tepepixqui_movil/pages/register/register_ong_form1.dart';
import 'package:tepepixqui_movil/pages/register/register_volunteer_election.dart';

class RegisterElection extends StatelessWidget {
  const RegisterElection({super.key});

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
                const SizedBox(height: 40),
                Image.asset(
                  'assets/images/logo.png',
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircularButton(
                      icon: Icons.people,
                      text: 'Si eres voluntario,\npulsa aquí',
                      onPressed: () {
                        Get.to(const RegisterVolunteerElection());
                      },
                      heroTag: 'voluntarioHeroTag',
                    ),
                    CircularButton(
                      icon: Icons.apartment,
                      text: 'Si eres una ONG,\npulsa aquí',
                      onPressed: () {
                        Get.to(RegisterOngForm1());
                      },
                      heroTag: 'ongHeroTag',
                    ),
                  ],
                ),
                const SizedBox(height: 100),
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
