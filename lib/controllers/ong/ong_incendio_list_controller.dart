import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tepepixqui_movil/models/incendio.dart';


class IncendioListController extends GetxController {
  final RxList<IncendioModel> incendiosActivos = <IncendioModel>[].obs;
  final RxList<IncendioModel> incendiosPasados = <IncendioModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchIncendios();
  }

  void fetchIncendios() {
    FirebaseFirestore.instance
        .collection('incendios')
        .snapshots()
        .listen((snapshot) {
      final List<IncendioModel> activosTemp = [];
      final List<IncendioModel> pasadosTemp = [];

      for (var doc in snapshot.docs) {
        final incendio = IncendioModel.fromMap(doc.id, doc.data());
        if (incendio.activo) {
          activosTemp.add(incendio);
        } else {
          pasadosTemp.add(incendio);
        }
      }

      incendiosActivos.value = activosTemp;
      incendiosPasados.value = pasadosTemp;
    });
  }

  void toggleIncendioStatus(IncendioModel incendio) {
    incendio.activo = !incendio.activo;
    incendio.update();
    fetchIncendios(); // Recargar la lista después de actualizar
  }
}