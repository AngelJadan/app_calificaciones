import 'package:app_calificaciones/controller/curso_controller.dart';
import 'package:app_calificaciones/controller/funcionario_controller.dart';
import 'package:app_calificaciones/controller/home_controller.dart';
import 'package:app_calificaciones/services/remote/persona_service.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';

class Injection {
  static void init() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => CursoController());
    Get.lazyPut(() => FuncionarioController());
    Get.lazyPut(() => PersonaService());
  }
}
