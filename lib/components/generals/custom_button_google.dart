import 'package:flutter/material.dart';
import 'package:tepepixqui_movil/components/generals/custom_dialog.dart';

class CustomButtonGoogle extends StatelessWidget {
  final String imagePath;

  const CustomButtonGoogle({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomDialogController.showCustomDialog("Esto no esta funcionando");
        // LoginGoogleController().loginWithGoogle();
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[300],
        ),
        child: Image.asset(
          imagePath,
          height: 40,
        ),
      ),
    );
  }
}
