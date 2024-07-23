import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tepepixqui_movil/components/custom_dialog.dart';
import 'package:tepepixqui_movil/utils/database/login_querys.dart';

class ForgotPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();

  GlobalKey<FormState> forgotPasswordForm = GlobalKey<FormState>();
  var isLoading = false.obs;
  var message = ''.obs;

  Future<void> resetPassword() async {
    if (!forgotPasswordForm.currentState!.validate()) {
      return;
    }

    if (!await LoginQuerys.checkIfFieldExists(
        "correoElectronico", emailController.text.trim().toLowerCase())) {
      message.value = "No hay una cuenta asociada con dicho correo";
    } else {
      isLoading.value = true;
      try {
        await _auth.sendPasswordResetEmail(email: emailController.text);
        message.value = 'Correo enviado';
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'invalid-email':
            message.value = 'Correo electrónico no válido';
            break;
          case 'user-not-found':
            message.value = 'Usuario no encontrado';
            break;
          case 'network-request-failed':
            message.value = 'Error de red';
            break;
          default:
            message.value = 'Error desconocido';
            break;
        }
      } catch (error) {
        message.value = 'Error desconocido';
      } finally {
        isLoading.value = false;
      }
    }
    CustomDialogController.showCustomDialog(message.value);
  }
}
