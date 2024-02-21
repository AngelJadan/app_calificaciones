import 'package:app_calificaciones/router/router.dart';
import 'package:app_calificaciones/views/curso/curso_page.dart';
import 'package:app_calificaciones/views/funcionario/funcionario_page.dart';
import 'package:app_calificaciones/views/home.dart';
import 'package:app_calificaciones/views/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class Pages {
  static final List<GetPage> pages = [
    GetPage(name: Routers.HOME, page: () => HomePage()),
    GetPage(
      name: Routers.CURSO,
      page: () => CursoPage(),
    ),
    GetPage(
      name: Routers.FUNCIONARIO,
      page: () => FuncionarioPage(),
    ),
  ];
}
