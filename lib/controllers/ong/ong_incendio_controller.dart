import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tepepixqui_movil/components/generals/custom_dialog.dart';
import 'package:tepepixqui_movil/utils/validations/validations_incendio.dart';

class IncendioController extends GetxController {
  var fechaInicio = DateTime.now().obs;

  TextEditingController duracion = TextEditingController();

  var tipoVegetacion = 'Bosque de coníferas'.obs;
  var intensidad = 'Baja'.obs;
  var colorDelHumo = 'Blanco'.obs;
  var viento = 'Norte'.obs;
  var temperatura = '11-20°C'.obs;
  var humedad = '< 30%'.obs;

  Rx<LatLng> ubicacion =
      const LatLng(0, 0).obs; // Variable observable para la ubicación

  final List<String> tiposVegetacion = [
    'Bosque de coníferas',
    'Bosque de frondosas',
    'Pastizal',
    'Sabana',
    'Matorral',
    'Selva'
  ];
  final List<String> intensidades = ['Baja', 'Moderada', 'Alta'];
  final List<String> coloresHumo = ['Blanco', 'Gris', 'Negro', 'Marrón'];

  var isLocationSelected = false.obs;

  // Nuevas listas para campos meteorológicos
  final List<String> direccionesViento = [
    'Norte',
    'Sur',
    'Este',
    'Oeste',
    'Calma'
  ];
  final List<String> temperaturas = ['11-20°C', '21-30°C', '31-40°C', '> 40°C'];
  final List<String> humedades = [
    '< 30%',
    '30-50%',
    '51-70%',
    '71-90%',
    '> 90%'
  ];

  void setFechaInicio(DateTime date) {
    fechaInicio.value = date;
  }

  void setFecha(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Fecha inicial es el día actual
      firstDate: DateTime.now(), // Limita a fechas futuras
      lastDate: DateTime(2100), // Hasta el año 2100
    );

    if (picked != null && picked != fechaInicio.value) {
      setFechaInicio(picked);
    }
  }

  void setLocation(LatLng location) {
    ubicacion.value = location;
    isLocationSelected.value = true; // Actualizar la variable booleana
    print(
        'Ubicación seleccionada: ${location.latitude}, ${location.longitude}');
  }

  void uploadIncendio() {
    if (isLocationSelected.value == true) {
      CustomDialogController.showCustomDialog("Se selecciono ubi");
    }
    else{        CustomDialogController.showCustomDialog("No se selecciono ubi");

    }
    String duration = duracion.value.text;

    if (ValidationsIncendio.validarDuracion(duration) != null) {
      return;
    }

    print('Tipo de Vegetación: ${tipoVegetacion.value}');
    print('Intensidad: ${intensidad.value}');
    print('Color del Humo: ${colorDelHumo.value}');
    print('Viento: ${viento.value}');
    print('Temperatura: ${temperatura.value}');
    print('Humedad: ${humedad.value}');
  }
}
