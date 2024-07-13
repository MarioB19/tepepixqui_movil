import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/firebase_options.dart';
import 'package:tepepixqui_movil/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura que los widgets estén inicializados

 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Login',
      debugShowCheckedModeBanner: false, // Aquí se desactiva la etiqueta de debug
      home: LoginPage(),
    );
  }
}
