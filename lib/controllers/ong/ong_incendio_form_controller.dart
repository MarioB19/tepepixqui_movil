import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tepepixqui_movil/components/generals/custom_dialog.dart';
import 'package:tepepixqui_movil/models/incendio.dart';
import 'package:tepepixqui_movil/pages/ong/oportunidades/ong_oportunidades_index.dart';
import 'package:tepepixqui_movil/utils/services/files_service.dart';
import 'package:tepepixqui_movil/utils/validations/validations_incendio.dart';

class OngIncendioFormController extends GetxController {
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

  var images = <File>[].obs;
  final ImagePicker _picker = ImagePicker();

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

  Future<void> uploadIncendio() async {
    if (isLocationSelected.value == false) {
      CustomDialogController.showCustomDialog(
          "Debe seleccionar por lo menos una ubicacion");
      return;
    }

    String duration = duracion.value.text;

    if (ValidationsIncendio.validarDuracion(duration) != null) {
      return;
    }

    if (images.value.isEmpty) {
      CustomDialogController.showCustomDialog(
          "Debe seleccionar por lo menos una imagen");
      return;
    }

    List<String> urlImages = await FilesService.uploadFiles(images);

    IncendioModel incendio = new IncendioModel(
        ubicacionLatitud: ubicacion.value.latitude,
        ubicacionLongitud: ubicacion.value.longitude,
        fechaInicio: fechaInicio.value,
        duracion: duration,
        tipoVegetacion: tipoVegetacion.value,
        intensidad: intensidad.value,
        colorDelHumo: colorDelHumo.value,
        fotografias: urlImages,
        viento: viento.value,
        temperatura: temperatura.value,
        humedad: humedad.value);

    await incendio.create();

    resetFields();

    Get.back();

    Get.back();

    CustomDialogController.showCustomDialog("Incendio creado correctamente");
  }

  Future<void> addImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      images.add(File(pickedFile.path));
    }
  }

  void removeImage(int index) {
    images.removeAt(index);
  }

  void resetFields() {
    fechaInicio.value = DateTime.now();
    duracion.clear();
    tipoVegetacion.value = 'Bosque de coníferas';
    intensidad.value = 'Baja';
    colorDelHumo.value = 'Blanco';
    viento.value = 'Norte';
    temperatura.value = '11-20°C';
    humedad.value = '< 30%';
    ubicacion.value = const LatLng(0, 0);
    isLocationSelected.value = false;
    images.clear();
  }
}
