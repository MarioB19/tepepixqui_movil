import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/incendio/incendio_preview.dart';
import 'package:tepepixqui_movil/controllers/ong/ong_incendio_list_controller.dart';


class IncendioPage extends StatelessWidget {
  final IncendioListController controller = Get.put(IncendioListController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Incendios'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Activos'),
              Tab(text: 'Pasados'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab para Incendios Activos
            Obx(() {
              if (controller.incendiosActivos.isEmpty) {
                return Center(child: Text('No hay incendios activos.'));
              }
              return ListView.builder(
                itemCount: controller.incendiosActivos.length,
                itemBuilder: (context, index) {
                  var incendio = controller.incendiosActivos[index];
                  return IncendioPreview(
                    incendio: incendio,
                    onToggleStatus: () => controller.toggleIncendioStatus(incendio),
                  );
                },
              );
            }),
            // Tab para Incendios Pasados
            Obx(() {
              if (controller.incendiosPasados.isEmpty) {
                return Center(child: Text('No hay incendios pasados.'));
              }
              return ListView.builder(
                itemCount: controller.incendiosPasados.length,
                itemBuilder: (context, index) {
                  var incendio = controller.incendiosPasados[index];
                  return IncendioPreview(
                    incendio: incendio,
                    onToggleStatus: () => controller.toggleIncendioStatus(incendio),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}