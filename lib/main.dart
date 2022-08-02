
import 'package:delicias_da_auzi/src/pages/auth/controller/auth_controller.dart';
import 'package:delicias_da_auzi/src/pages/auth/view/sign_in_screen.dart';
import 'package:delicias_da_auzi/src/pages/splash/splash_screen.dart';
import 'package:delicias_da_auzi/src/pages_routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Delicias da Auzi',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.white.withAlpha(190)
      ),
      debugShowCheckedModeBanner: false,

      initialRoute: PagesRoutes.splashRoute,

      getPages: AppPages.pages,
    );
  }
}

