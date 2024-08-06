import 'package:get/get.dart';
import 'package:tepepixqui_movil/models/incendio.dart'; // Asegúrate de tener un modelo de Incendio

class IncendioListController extends GetxController {
  var incendiosActivos = <IncendioModel>[].obs;
  var incendiosPasados = <IncendioModel>[].obs;

  // Simulación de la carga de datos
  void cargarIncendios() {
    incendiosActivos.addAll([
      // Añade incendios de ejemplo aquí
      //IncendioModel(ubicacionLatitud: 19.432608, ubicacionLongitud: -99.133209),
      // Más datos de ejemplo...
    ]);
    incendiosPasados.addAll([
      // Añade incendios de ejemplo aquí
     // IncendioModel(ubicacionLatitud: 34.052235, ubicacionLongitud: -118.243683),
      // Más datos de ejemplo...
    ]);
  }

  @override
  void onInit() {
    super.onInit();
    cargarIncendios();
  }
}
