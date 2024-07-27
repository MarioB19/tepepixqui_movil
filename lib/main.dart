import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tepepixqui_movil/controllers/auth_controller.dart';
import 'package:tepepixqui_movil/controllers/navigation/theme_controller.dart';
import 'package:tepepixqui_movil/firebase_options.dart';
import 'package:tepepixqui_movil/pages/error_page.dart';
import 'package:tepepixqui_movil/pages/login_page.dart';
import 'package:tepepixqui_movil/pages/ong/index_ong.dart';
import 'package:tepepixqui_movil/pages/volunteer/index_volunteer.dart';
import 'package:tepepixqui_movil/utils/services/location_service.dart';
import 'package:tepepixqui_movil/utils/time.dart';
import 'theme/theme_data.dart';

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
  Get.put(ThemeController());


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() {
      return GetMaterialApp(
        title: 'Tepepixqui',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeController.theme,
        home: HomeRouter(),
      );
    });
  }
}

class HomeRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Obx(() {
      if (authController.currentUser.value != null) {
        return UserHome();
      } else {
        return LoginPage();
      }
    });
  }
}

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late Future<String> userTypeFuture;
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    userTypeFuture = authController.getUserType(authController.currentUser.value!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: userTypeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return ErrorPage();
        } else if (snapshot.hasData) {
          if (snapshot.data == "volunteer") {
            return IndexVolunteer();
          } else if (snapshot.data == "ong") {
            return IndexOng();
          } else {
            return ErrorPage();
          }
        } else {
          return LoginPage();
        }
      },
    );
  }
}
