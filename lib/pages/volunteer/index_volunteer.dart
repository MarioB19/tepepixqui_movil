import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/generals/custom_curved_navigation_bar.dart';
import 'package:tepepixqui_movil/components/generals/custom_dialog.dart';
import 'package:tepepixqui_movil/components/generals/custom_header.dart';
import 'package:tepepixqui_movil/controllers/auth_controller.dart';

import 'package:tepepixqui_movil/pages/volunteer/concientizacion/volunteer_concientizacion_index.dart';
import 'package:tepepixqui_movil/pages/volunteer/difusion/volunteer_difusion_index.dart';
import 'package:tepepixqui_movil/pages/volunteer/donaciones/volunteer_donaciones_index.dart';
import 'package:tepepixqui_movil/pages/volunteer/incendios/volunteer_incendios_index.dart';
import 'package:tepepixqui_movil/pages/volunteer/perfil/volunteer_perfil_index.dart';

class IndexVolunteer extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  IndexVolunteer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        logoPath: 'assets/images/logo_indoor.png',
        redirectUrl: "https://tepepixqui.vercel.app/",
        onReportIconPressed: () {
          CustomDialogController.showCustomDialog(
              "Nos encontramos trabajando los informes :)");
        },
        onLogoutPressed: () async {
          await authController.logout();
        },
      ),
      body: CustomCurvedNavigationBar(
        pages: [
          ConcientizacionPage(),
          IncendiosPage(),
          DifusionPage(),
          DonacionesPage(),
          VolunteerProfilePage(volunteerId: authController.getUid()!)
        ],
        icons: const [
          Icons.school,
          Icons.fireplace_outlined,
          Icons.campaign_outlined,
          Icons.volunteer_activism_outlined,
          Icons.person,
        ],
      ),
    );
  }
}
