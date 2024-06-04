import 'package:app_calificaciones/controller/curso_controller.dart';
import 'package:app_calificaciones/controller/curso_estudiante_controller.dart';
import 'package:app_calificaciones/controller/curso_periodo_controller.dart';
import 'package:app_calificaciones/controller/docente_controller.dart';
import 'package:app_calificaciones/controller/estudiante_controller.dart';
import 'package:app_calificaciones/controller/funcionario_controller.dart';
import 'package:app_calificaciones/controller/home_controller.dart';
import 'package:app_calificaciones/controller/materia_controller.dart';
import 'package:app_calificaciones/controller/materia_curso_docente_controller.dart';
import 'package:app_calificaciones/controller/periodo_controller.dart';
import 'package:app_calificaciones/services/remote/estudiante_service.dart';
import 'package:app_calificaciones/services/remote/materia_curso_docente_service.dart';
import 'package:app_calificaciones/services/remote/materia_estudiante_service.dart';
import 'package:app_calificaciones/services/remote/materia_service.dart';
import 'package:app_calificaciones/services/remote/periodo_service.dart';
import 'package:app_calificaciones/services/remote/persona_service.dart';
import 'package:app_calificaciones/services/remote/trimestre_service.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';
import '../services/remote/curso_service.dart';

class Injection {
  static void init() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => HomeController());

    Get.lazyPut(() => CursoController());
    Get.lazyPut(() => CursoService());

    Get.lazyPut(() => MateriaService());
    Get.lazyPut(() => MateriaController());

    Get.lazyPut(() => FuncionarioController());
    Get.lazyPut(() => PersonaService());
    Get.lazyPut(() => DocenteController());

    Get.lazyPut(() => EstudianteController());
    Get.lazyPut(() => EstudianteService());
    Get.lazyPut(() => PeriodoController());
    Get.lazyPut(() => PeriodoService());

    Get.lazyPut(() => MateriaCursoDocenteController());
    Get.lazyPut(() => MateriaCursoDocenteService());

    Get.lazyPut(() => CursoEstudianteController());
    Get.lazyPut(() => MateriaEstudianteService());

    Get.lazyPut(() => CursoPeriodoController());

    Get.lazyPut(() => TrimestreService());
  }
}
