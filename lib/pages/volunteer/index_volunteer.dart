import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/components/generals/custom_curved_navigation_bar.dart';
import 'package:tepepixqui_movil/components/generals/custom_header.dart';
import 'package:tepepixqui_movil/controllers/auth_controller.dart';

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
          print('Ícono de informes presionado');
        },
        onLogoutPressed: () async {
          await authController.logout();
        },
      ),

      body: CustomCurvedNavigationBar(
        pages: [
          Center(
            child: Text(
              'Hola, soy voluntario ${authController.getUid()}',
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const Center(child: Text('Página 2')),
          const Center(child: Text('Página 3')),
          const Center(child: Text('Página 4')),
          const Center(child: Text('Página 5')),
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
