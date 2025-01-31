import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/generals/custom_button.dart';
import 'package:tepepixqui_movil/components/generals/custom_text_field.dart';
import 'package:tepepixqui_movil/components/generals/theme_switcher.dart';
import 'package:tepepixqui_movil/controllers/navigation/theme_controller.dart';
import 'package:tepepixqui_movil/controllers/register/register_ong_controller.dart';
import 'package:tepepixqui_movil/utils/validations/login/validations_ong.dart';

class RegisterOngForm2 extends StatelessWidget {
  final RegisterOngController controller = Get.find();
  final ThemeController themeController = Get.find<ThemeController>();

  RegisterOngForm2({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx((){

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro ONG'),
        actions: [ThemeSwitcher()],
        backgroundColor: themeController.appBarLogin(),
      ),
      body: Form(
        key: controller.signupFormKey2,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  hintText:
                      'Ingresa aquí la descripción de las actividades que llevan como ONG o Asociación',
                  controller: controller.actividadesController,
                  onChanged: (value) {},
                  isPassword: false,
                  keyboardType: TextInputType.multiline,
                  validator: (value) =>
                      ValidationsOng.validarDescripcionActividades(value),
                  maxLines: 5, // Establecer el máximo de líneas
                  minLines: 1, // Establecer el mínimo de líneas
                ),
                const SizedBox(height: 20),
                const Text(
                  'Carga una carta notariada de validación que los acredite como Organizaciones de Sociedad Civil en formato PDF',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Seleccionar PDF',
                  onPressed: controller.pickPDF,
                  backgroundColor: Colors.blue,
                ),
                Obx(() {
                  if (controller.pdfFileName.value != null) {
                    return Text(
                      'Archivo PDF seleccionado: ${controller.pdfFileName.value}',
                      style: const TextStyle(color: Colors.blue),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
                const SizedBox(height: 25),
                CustomButton(
                  text: "Terminar solicitud de registro",
                  onPressed: () {
                    controller.signupPart2();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );});
  }
}
