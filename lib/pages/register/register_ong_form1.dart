import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/generals/custom_button.dart';
import 'package:tepepixqui_movil/components/generals/custom_text_field.dart';
import 'package:tepepixqui_movil/components/generals/theme_switcher.dart';
import 'package:tepepixqui_movil/controllers/navigation/theme_controller.dart';
import 'package:tepepixqui_movil/controllers/register/register_ong_controller.dart';
import 'package:tepepixqui_movil/pages/login_page.dart';
import 'package:tepepixqui_movil/utils/validations/login/validations_ong.dart';

class RegisterOngForm1 extends StatelessWidget {
  final controller = Get.put(RegisterOngController());
  final ThemeController themeController = Get.find<ThemeController>();
  RegisterOngForm1({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Petición Registro'),
          actions: [ThemeSwitcher()],
          backgroundColor: themeController.appBarLogin(),
        ),
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
                      hintText: "Nombre de la ONG o asociacion",
                      controller: controller.nombreONGController,
                      onChanged: (value) {},
                      isPassword: false,
                      keyboardType: TextInputType.text,
                      validator: (value) =>
                          ValidationsOng.validarNombreOrganizacion(value),
                    ),
                    const SizedBox(height: 30),
                    Obx(() {
                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Tiempo en funcionamiento",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        value: controller.tiempoFuncionamiento.value,
                        items: [
                          "0 años",
                          "1 año",
                          "2 años",
                          "3 años",
                          "4 años",
                          "+5 años"
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: controller.setTiempoFuncionamiento,
                      );
                    }),
                    const SizedBox(height: 30),
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
                              controller: controller.numTelefonoController,
                              onChanged: (value) {},
                              isPassword: false,
                              keyboardType: TextInputType.phone,
                              validator: (value) => ValidationsOng
                                  .validarNumeroTelefonicoOrganizacion(value),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      hintText:
                          "Nombre completo del representante de\n la Asociacion/ONG",
                      controller: controller.nombreRepresentanteController,
                      onChanged: (value) {},
                      isPassword: false,
                      keyboardType: TextInputType.text,
                      validator: (value) =>
                          ValidationsOng.validarNombreRepresentante(value),
                    ),
                    const SizedBox(height: 30),
                    Obx(() {
                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText:
                              "Cantidad de Personas en la Asociacion/ONG",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        value: controller.cantidadPersonas.value,
                        items: [
                          "1-25 personas",
                          "25-50 personas",
                          "50-75 personas",
                          "+75 personas"
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: controller.setCantidadPersonas,
                      );
                    }),
                    const SizedBox(height: 30),
                    Obx(() {
                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Nivel en que la Asociacion/ONG opera",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        value: controller.nivelOperativo.value,
                        items: ["Internacional", "Nacional", "Estatal", "Local"]
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: controller.setNivelOperativo,
                      );
                    }),
                    const SizedBox(height: 30),
                    CustomTextField(
                      hintText: "Correo electrónico",
                      controller: controller.correoController,
                      onChanged: (value) {},
                      isPassword: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          ValidationsOng.validarCorreoElectronicoOrganizacion(
                              value),
                    ),
                    const SizedBox(height: 30),
                    Obx(() {
                      return CustomTextField(
                        hintText: "Contraseña",
                        controller: controller.passwordController,
                        onChanged: (value) {},
                        isPassword: true,
                        isPasswordVisible: controller.obscurePassword.value,
                        onVisibilityToggle: controller.toggleObscurePassword,
                        keyboardType: TextInputType.text,
                        validator: (value) =>
                            ValidationsOng.validarContrasenaOrganizacion(value),
                      );
                    }),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: 'Siguiente',
                      onPressed: () => controller.signupPart1(),
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Ya tienes una cuenta?"),
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
    });
  }
}
