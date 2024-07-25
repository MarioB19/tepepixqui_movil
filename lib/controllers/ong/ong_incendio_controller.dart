import 'package:get/get.dart';

class IncendioController extends GetxController {
  var ubicacion = ''.obs;
  var fechaInicio = DateTime.now().obs;
  var duracion = Duration(hours: 1).obs;
  var tamanoAproximado = ''.obs;
  var tipoVegetacion = ''.obs;
  var intensidad = ''.obs;
  var colorDelHumo = ''.obs;
  var fotografias = <String>[].obs;
  var viento = ''.obs;
  var temperatura = ''.obs;
  var humedad = ''.obs;

  void setFechaInicio(DateTime date) {
    fechaInicio.value = date;
  }

  void setDuracion(int hours) {
    duracion.value = Duration(hours: hours);
  }
}
