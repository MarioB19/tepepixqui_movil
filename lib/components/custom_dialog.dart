import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialogController {
  // Método estático para mostrar el diálogo
  static void showCustomDialog(String message) {
    Get.dialog(
      AnimatedContainer(
        duration: const Duration(seconds: 1), // Duración de la animación
        curve: Curves.easeInOut, // Tipo de animación
        child: AlertDialog(
          backgroundColor: Colors.green[100],
          title: Text('Aviso Importante', style: TextStyle(color: Colors.green[900])),
          content: Text(message, style: TextStyle(color: Colors.green[800])),  // Usar el mensaje pasado como parámetro
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar', style: TextStyle(color: Colors.green[900])),
              onPressed: () => Get.back(), // Utilizar Get.back() para cerrar el diálogo
            ),
          ],
        ),
      ),
      barrierDismissible: false, // Hace que el diálogo no se pueda cerrar tocando fuera de él
    );

    // Cerrar el diálogo automáticamente después de 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
    });
  }
}
