import 'dart:io';

import 'package:app_calificaciones/router/pages.dart';
import 'package:app_calificaciones/views/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'utils/injection.dart';

void main() {
  runApp(const AppCalificaciones());
}

class AppCalificaciones extends StatelessWidget {
  const AppCalificaciones({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Injection.init();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calificaciones",
      theme: ThemeData(
        fontFamily: "Georgia",
      ),
      home: const LoginView(),
      getPages: Pages.pages,
      locale: Get.deviceLocale,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
