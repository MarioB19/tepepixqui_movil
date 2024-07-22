import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isPasswordVisible = false.obs;
  final TextEditingController usernameOrCorreoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void setEmail(String value) {
    email.value = value;
  }

  void setPassword(String value) {
    password.value = value;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() {
    // Aquí puedes implementar la lógica de login
    if (email.value == "test@example.com" && password.value == "password") {
      Get.snackbar('Login Successful', 'Welcome!');
    } else {
      Get.snackbar('Login Failed', 'Invalid email or password');
    }
  }
}
