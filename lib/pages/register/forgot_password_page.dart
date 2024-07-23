import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/generals/custom_button.dart';
import 'package:tepepixqui_movil/components/generals/custom_text_field.dart';
import 'package:tepepixqui_movil/controllers/forgot_password_controller.dart';
import 'package:tepepixqui_movil/utils/validations/login/validations_ong.dart';

class ForgotPasswordPage extends StatelessWidget {
  final ForgotPasswordController controller = Get.put(ForgotPasswordController());

  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restablecer Contraseña',
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.green),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: controller.forgotPasswordForm,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/logo.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20),
              const Text(
                'Ingresa tu correo electrónico para restablecer tu contraseña',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Te enviaremos un enlace para restablecer tu contraseña a la dirección de correo electrónico proporcionada.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
               CustomTextField(
                      hintText: "Correo electrónico",
                      controller: controller.emailController,
                      onChanged: (value) {},
                      isPassword: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          ValidationsOng.validarCorreoElectronicoOrganizacion(
                              value),
                    ),
              const SizedBox(height: 20),
              Obx(() {
                return controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        text: 'Restablecer Contraseña',
                        onPressed: controller.resetPassword,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
