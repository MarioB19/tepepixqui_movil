import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/custom_dialog.dart';
import 'package:tepepixqui_movil/utils/database/login_querys.dart';

class LoginController extends GetxController {
  var field = ''.obs;
  var password = ''.obs;
  var isPasswordVisible = false.obs;
  final TextEditingController usernameOrCorreoController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    String usernameOrCorreo =
        usernameOrCorreoController.value.text.trim().toLowerCase();
    String password = passwordController.value.text;

    Map<String, dynamic> result =
        await LoginQuerys.signInWithUsernameOrEmail(usernameOrCorreo, password);

    if (result['loginStatus']) {
      CustomDialogController.showCustomDialog('Login ok');
    } else {
      CustomDialogController.showCustomDialog(result['messageError']);
    }
  }
}
