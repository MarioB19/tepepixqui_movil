import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/generals/custom_button_circular.dart';
import 'package:tepepixqui_movil/components/incendio_form.dart';

class OngOportunidadesIndex extends StatelessWidget {
  const OngOportunidadesIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body: Center(
        child: Text('Contenido de la página'),
      ),
      floatingActionButton: CircularButton(
        icon: Icons.add,
        text: '',
        onPressed: () {
          Get.to(IncendioForm());
        },
        heroTag: 'unique_tag', // HeroTag único
        backgroundColor: Colors.blue, // Color personalizado
        foregroundColor: Colors.white, // Color de texto personalizado
        size: 70.0, // Tamaño personalizado
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Parte inferior derecha
    );
  }
}
