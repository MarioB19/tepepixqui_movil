import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/controllers/auth_controller.dart';
import 'package:tepepixqui_movil/firebase_options.dart';
import 'package:tepepixqui_movil/pages/error_page.dart';
import 'package:tepepixqui_movil/pages/login_page.dart';
import 'package:tepepixqui_movil/pages/ong/index_ong.dart';
import 'package:tepepixqui_movil/pages/volunteer/index_volunteer.dart';
import 'package:tepepixqui_movil/utils/time.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Time.setupTimeZone();

  Get.put(AuthController());

  runApp(const GetMaterialApp(
    //theme: lightMode,
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: lightMode,
      home: Obx(() {
        if (authController.currentUser.value != null) {
          String? uid = authController.getUid();
          if (uid != null) {
            return FutureBuilder<String>(
              future: authController.getUserType(uid),
              builder: (context, snapshotTipoUsuario) {
                if (snapshotTipoUsuario.connectionState ==
                    ConnectionState.waiting) {
                  return const LinearProgressIndicator();
                } else if (snapshotTipoUsuario.hasError) {
                  return Text('Error: ${snapshotTipoUsuario.error}');
                } else if (snapshotTipoUsuario.hasData) {
                  if (snapshotTipoUsuario.data == "volunteer") {
                    return IndexVolunteer();
                  } else if (snapshotTipoUsuario.data == "ong") {
                    return IndexOng();
                  } else {
                    return ErrorPage();
                  }
                } else {
                  return LoginPage();
                }
              },
            );
          } else {
            return LoginPage();
          }
        } else {
          return LoginPage();
        }
      }),
    );
  }
}
