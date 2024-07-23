import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/generals/custom_dialog.dart';
import 'package:tepepixqui_movil/controllers/auth_controller.dart';
import 'package:tepepixqui_movil/pages/ong/index_ong.dart';
import 'package:tepepixqui_movil/pages/volunteer/index_volunteer.dart';
import 'package:tepepixqui_movil/utils/database/login_querys.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  final TextEditingController usernameOrCorreoController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.put(AuthController());

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
      authController.login(result['email'], password, result['userType']);

      if (result['userType'] == "ong") {
        Get.offAll(IndexOng());
      } else if (result['userType'] == "voluntario") {
        Get.offAll(IndexVolunteer());
      }
      clear();
    } else {
      CustomDialogController.showCustomDialog(result['messageError']);
    }
  }

  void clear() {
    passwordController.clear();
    usernameOrCorreoController.clear();
  }
}
