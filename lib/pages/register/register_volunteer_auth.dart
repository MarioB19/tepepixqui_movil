
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/generals/custom_button.dart';
import 'package:tepepixqui_movil/components/generals/custom_text_field.dart';
import 'package:tepepixqui_movil/controllers/register/register_volunteer_controller.dart';
import 'package:tepepixqui_movil/pages/login_page.dart';
import 'package:tepepixqui_movil/utils/validations/login/validations_volunteer.dart';

class RegisterVolunteerAuth extends StatelessWidget {
  final User? user;
  final String provedor;

  RegisterVolunteerAuth({super.key, required this.user, required this.provedor});

  final RegisterVolunteerController controller = Get.put(RegisterVolunteerController());

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != controller.selectedDate.value) {
      controller.updateFechaNacimiento(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: controller.signupFormKey,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Image.asset(
                    'lib/images/logo.png',
                    width: 250,
                    height: 250,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: "Número de Teléfono",
                    controller: controller.numerotelefono,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {},
                    validator: (value) => ValidationsVolunteer.validarCelular(value),
                    icon: Icons.phone,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: "Fecha de Nacimiento",
                    controller: controller.fechaNacimiento,
                    keyboardType: TextInputType.datetime,
                    onChanged: (value) {},
                    validator: (value) => ValidationsVolunteer.validarEdad(value!),
                    readOnly: true,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: "Nombre de Usuario",
                    controller: controller.username,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    validator: (value) => ValidationsVolunteer.validarNombreUsuario(value),
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: "Terminar registro",
                    onPressed: () => controller.guardarDatosFaltantes(user, provedor),
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () => Get.offAll(LoginPage()),
                    child: const Text(
                      "Ya tienes una cuenta? Inicia sesión aquí",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
