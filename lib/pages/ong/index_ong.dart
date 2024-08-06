import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/generals/custom_curved_navigation_bar.dart';
import 'package:tepepixqui_movil/components/generals/custom_header.dart';
import 'package:tepepixqui_movil/controllers/auth_controller.dart';
import 'package:tepepixqui_movil/pages/ong/alertas/ong_alertas_index.dart';
import 'package:tepepixqui_movil/pages/ong/donaciones/ong_donaciones_index.dart';
import 'package:tepepixqui_movil/pages/ong/oportunidades/ong_oportunidades_index.dart';
import 'package:tepepixqui_movil/pages/ong/perfil/ong_perfil_index.dart';

class IndexOng extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  IndexOng({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: CustomHeader(
        logoPath: 'assets/images/logo_indoor.png',
        redirectUrl: "https://tepepixqui.vercel.app/",
        onReportIconPressed: () {
          print('Ícono de informes presionado');
        },
        onLogoutPressed: () async {
          await authController.logout();
        },
      ),

      body: CustomCurvedNavigationBar(
        pages: [
          VistaAlertas(),
          const Center(child: Text('Página 2')),
          const OngOportunidadesIndex(),
          VistaDonacionesRecursos(),
          OngPerfilIndex(ongId: authController.getUid()!)
        ],
        icons: const [
          Icons.warning_amber_outlined,
          Icons.group,
          Icons.local_fire_department_outlined,
          Icons.volunteer_activism_outlined,
          Icons.person
        ],
      ),
    );
  }
}
