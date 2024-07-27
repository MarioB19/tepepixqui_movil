import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tepepixqui_movil/components/generals/custom_dropdown_field.dart';
import 'package:tepepixqui_movil/components/generals/custom_text_field.dart';
import 'package:tepepixqui_movil/components/generals/theme_switcher.dart';
import 'package:tepepixqui_movil/components/location_picker.dart';
import 'package:tepepixqui_movil/controllers/navigation/theme_controller.dart';
import 'package:tepepixqui_movil/controllers/ong/ong_incendio_controller.dart';
import 'package:tepepixqui_movil/utils/validations/validations_incendio.dart';

class IncendioForm extends StatelessWidget {
  final ThemeController themeController = Get.find<ThemeController>();
  final IncendioController controller = Get.put(IncendioController());

  IncendioForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar incendio"),
        actions: [ThemeSwitcher()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Ingresar Ubicación ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.location_on),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            LocationPicker(
              height: 500,
               onLocationSelected: (LatLng location) {
                    controller.setLocation(location); // Llamar al método del controlador
                  },
            ),
            const SizedBox(height: 16),
            Obx(() => GestureDetector(
                  onTap: () async {
                    controller.setFecha(context);
                  },
                  child: AbsorbPointer(
                    child: CustomTextField(
                      labelText: 'Fecha de inicio del incendio',
                      hintText: 'Fecha de Inicio',
                      controller: TextEditingController(
                          text: controller.fechaInicio.value
                              .toLocal()
                              .toString()
                              .split(' ')[0]),
                      onChanged: (value) {},
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => {},
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 24),
            CustomTextField(
              labelText: "Cuanto tiempo lleva el incendio",
              hintText: 'Duración (horas)',
              controller: controller.duracion,
              keyboardType: TextInputType.number,
              onChanged: (value) {},
              validator: (value) {
                return ValidationsIncendio.validarDuracion(value);
              },
              suffixIcon: const Icon(Icons.timer),
            ),
            const SizedBox(height: 16),
            Obx(() => CustomDropdownField<String>(
                  fieldName: "Tipo de Vegetacion",
                  hintText: 'Tipo de Vegetación',
                  value: controller.tipoVegetacion.value.isEmpty
                      ? controller.tiposVegetacion.first
                      : controller.tipoVegetacion.value,
                  items: controller.tiposVegetacion,
                  onChanged: (newValue) =>
                      controller.tipoVegetacion.value = newValue ?? '',
                  icon: Icons.nature,
                )),
            const SizedBox(height: 16),
            Obx(() => CustomDropdownField<String>(
                  fieldName: "Intensidad del incendio",
                  hintText: 'Intensidad',
                  value: controller.intensidad.value.isEmpty
                      ? controller.intensidades.first
                      : controller.intensidad.value,
                  items: controller.intensidades,
                  onChanged: (newValue) =>
                      controller.intensidad.value = newValue ?? '',
                  icon: Icons.whatshot,
                )),
            const SizedBox(height: 16),
            Obx(() => CustomDropdownField<String>(
                  fieldName: "Color de humo del incendio",
                  hintText: 'Color del Humo',
                  value: controller.colorDelHumo.value.isEmpty
                      ? controller.coloresHumo.first
                      : controller.colorDelHumo.value,
                  items: controller.coloresHumo,
                  onChanged: (newValue) =>
                      controller.colorDelHumo.value = newValue ?? '',
                  icon: Icons.cloud,
                )),
            const SizedBox(height: 16),
            Obx(() => CustomDropdownField<String>(
                  fieldName: "Direccion del viento en el lugar",
                  hintText: 'Dirección del Viento',
                  value: controller.viento.value.isEmpty
                      ? controller.direccionesViento.first
                      : controller.viento.value,
                  items: controller.direccionesViento,
                  onChanged: (newValue) =>
                      controller.viento.value = newValue ?? '',
                  icon: Icons.air,
                )),
            const SizedBox(height: 16),
            Obx(() => CustomDropdownField<String>(
                  fieldName: "Temperatura en el lugar",
                  hintText: 'Temperatura',
                  value: controller.temperatura.value.isEmpty
                      ? controller.temperaturas.first
                      : controller.temperatura.value,
                  items: controller.temperaturas,
                  onChanged: (newValue) =>
                      controller.temperatura.value = newValue ?? '',
                  icon: Icons.thermostat,
                )),
            const SizedBox(height: 16),
            Obx(() => CustomDropdownField<String>(
                  fieldName: "Humedad en el lugar",
                  hintText: 'Humedad',
                  value: controller.humedad.value.isEmpty
                      ? controller.humedades.first
                      : controller.humedad.value,
                  items: controller.humedades,
                  onChanged: (newValue) =>
                      controller.humedad.value = newValue ?? '',
                  icon: Icons.water_drop,
                )),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                controller.uploadIncendio();
              },
              child: const Text('Registrar Incendio'),
            ),
          ],
        ),
      ),
    );
  }
}
