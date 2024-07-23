import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/generals/custom_button.dart';
import 'package:tepepixqui_movil/components/generals/custom_text_field.dart';
import 'package:tepepixqui_movil/controllers/register/register_volunteer_controller.dart';

import 'package:tepepixqui_movil/pages/login_page.dart';
import 'package:tepepixqui_movil/utils/validations/login/validations_volunteer.dart';

class RegisterVolunteerForm extends StatelessWidget {
  final RegisterVolunteerController controller =
      Get.put(RegisterVolunteerController());

  RegisterVolunteerForm({super.key});

  Future<void> _selectDate(BuildContext context) async {
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
                    'assets/images/logo.png',
                    width: 250,
                    height: 250,
                  ),
                  const SizedBox(height: 25),
                  CustomTextField(
                    hintText: "Nombre",
                    controller: controller.nombre,
                    onChanged: (value) {},
                    isPassword: false,
                    keyboardType: TextInputType.text,
                    validator: (value) =>
                        ValidationsVolunteer.validarNombre(value),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: "Apellidos",
                    controller: controller.apellidos,
                    onChanged: (value) {},
                    isPassword: false,
                    keyboardType: TextInputType.text,
                    validator: (value) =>
                        ValidationsVolunteer.validarApellidos(value),
                  ),
                  const SizedBox(height: 20),
                  InputDecorator(
                    decoration: InputDecoration(
                      labelText: "Número de Teléfono",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<String>(
                            items: ["+52"].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? value) {},
                            value: "+52",
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 3,
                          child: CustomTextField(
                            hintText: "Número",
                            controller: controller.numerotelefono,
                            onChanged: (value) {},
                            isPassword: false,
                            keyboardType: TextInputType.phone,
                            validator: (value) =>
                                ValidationsVolunteer.validarCelular(value),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: "Fecha de Nacimiento",
                    controller: controller.fechaNacimiento,
                    onChanged: (value) {},
                    isPassword: false,
                    keyboardType: TextInputType.datetime,
                    validator: (value) => ValidationsVolunteer.validarEdad(
                        controller.fechaNacimiento.text),
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
                    onChanged: (value) {},
                    isPassword: false,
                    keyboardType: TextInputType.text,
                    validator: (value) =>
                        ValidationsVolunteer.validarNombreUsuario(value),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: "Correo electrónico",
                    controller: controller.correo,
                    onChanged: (value) {},
                    isPassword: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        ValidationsVolunteer.validarCorreoElectronico(value),
                  ),
                  const SizedBox(height: 20),
                  Obx(() => CustomTextField(
                        hintText: "Contraseña",
                        controller: controller.password,
                        onChanged: (value) {},
                        isPassword: true,
                        isPasswordVisible: controller.obscurePassword.value,
                        onVisibilityToggle: controller.togglePasswordVisibility,
                        keyboardType: TextInputType.text,
                        validator: (value) =>
                            ValidationsVolunteer.validarContrasena(value),
                      )),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: "Terminar registro",
                    onPressed: controller.signup,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Ya tienes una cuenta?",
                        style: TextStyle(color: Colors.black),
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
      ),
    );
  }
}
