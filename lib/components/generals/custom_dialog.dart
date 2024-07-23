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
          backgroundColor: Colors.green[50], // Color de fondo más suave
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: Text(
            'Aviso Importante',
            style: TextStyle(
              color: Colors.green[900],
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              color: Colors.green[800],
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.red, // Texto blanco
              ),
              child: const Text(
                'Cerrar',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
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
