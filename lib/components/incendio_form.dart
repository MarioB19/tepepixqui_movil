import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/generals/custom_dropdown_field.dart';
import 'package:tepepixqui_movil/components/generals/custom_text_field.dart';
import 'package:tepepixqui_movil/controllers/ong/ong_incendio_controller.dart';

class IncendioForm extends StatelessWidget {
  final List<String> ubicaciones = ['Ubicación 1', 'Ubicación 2', 'Ubicación 3'];
  final List<String> tiposVegetacion = ['Bosque de coníferas', 'Bosque de frondosas', 'Pastizal', 'Sabana', 'Matorral', 'Selva'];
  final List<String> intensidades = ['Baja', 'Moderada', 'Alta'];
  final List<String> coloresHumo = ['Blanco', 'Gris', 'Negro', 'Marrón'];

  // Nuevas listas para campos meteorológicos
  final List<String> direccionesViento = ['Norte', 'Sur', 'Este', 'Oeste', 'Calma'];
  final List<String> temperaturas = ['< 0°C', '0-10°C', '11-20°C', '21-30°C', '31-40°C', '> 40°C'];
  final List<String> humedades = ['< 30%', '30-50%', '51-70%', '71-90%', '> 90%'];

  @override
  Widget build(BuildContext context) {
    final IncendioController controller = Get.put(IncendioController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Incendio'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Obx(() => GestureDetector(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: controller.fechaInicio.value,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null && picked != controller.fechaInicio.value) {
                  controller.setFechaInicio(picked);
                }
              },
              child: AbsorbPointer(
                child: CustomTextField(
                  hintText: 'Fecha de Inicio',
                  controller: TextEditingController(text: controller.fechaInicio.value.toLocal().toString().split(' ')[0]),
                  onChanged: (value) {},
                ),
              ),
            )),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: 'Duración (horas)',
              controller: TextEditingController(text: controller.duracion.value.inHours.toString()),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                controller.setDuracion(int.parse(value));
              },
            ),
            const SizedBox(height: 16),
            Obx(() => CustomDropdownField<String>(
              hintText: 'Tipo de Vegetación',
              value: controller.tipoVegetacion.value.isEmpty ? tiposVegetacion.first : controller.tipoVegetacion.value,
              items: tiposVegetacion,
              onChanged: (newValue) => controller.tipoVegetacion.value = newValue ?? '',
            )),
            const SizedBox(height: 16),
            Obx(() => CustomDropdownField<String>(
              hintText: 'Intensidad',
              value: controller.intensidad.value.isEmpty ? intensidades.first : controller.intensidad.value,
              items: intensidades,
              onChanged: (newValue) => controller.intensidad.value = newValue ?? '',
            )),
            const SizedBox(height: 16),
            Obx(() => CustomDropdownField<String>(
              hintText: 'Color del Humo',
              value: controller.colorDelHumo.value.isEmpty ? coloresHumo.first : controller.colorDelHumo.value,
              items: coloresHumo,
              onChanged: (newValue) => controller.colorDelHumo.value = newValue ?? '',
            )),
            const SizedBox(height: 16),
            Obx(() => CustomDropdownField<String>(
              hintText: 'Dirección del Viento',
              value: controller.viento.value.isEmpty ? direccionesViento.first : controller.viento.value,
              items: direccionesViento,
              onChanged: (newValue) => controller.viento.value = newValue ?? '',
            )),
            const SizedBox(height: 16),
            Obx(() => CustomDropdownField<String>(
              hintText: 'Temperatura',
              value: controller.temperatura.value.isEmpty ? temperaturas.first : controller.temperatura.value,
              items: temperaturas,
              onChanged: (newValue) => controller.temperatura.value = newValue ?? '',
            )),
            const SizedBox(height: 16),
            Obx(() => CustomDropdownField<String>(
              hintText: 'Humedad',
              value: controller.humedad.value.isEmpty ? humedades.first : controller.humedad.value,
              items: humedades,
              onChanged: (newValue) => controller.humedad.value = newValue ?? '',
            )),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes agregar la lógica para guardar los datos del formulario
              },
              child: Text('Registrar Incendio'),
            ),
          ],
        ),
      ),
    );
  }
}
