import 'package:app_calificaciones/router/router.dart';
import 'package:app_calificaciones/views/curso_estudiante/curso_estudiante_page.dart';
import 'package:app_calificaciones/views/curso/curso_page.dart';
import 'package:app_calificaciones/views/curso_estudiante/cursos_periodo_page.dart';
import 'package:app_calificaciones/views/docente_cursos.dart';
import 'package:app_calificaciones/views/login.dart';
import 'package:app_calificaciones/views/materia/materia_page.dart';
import 'package:app_calificaciones/views/materia_curso_docente_periodo/materia_curso_docente_periodo_page.dart';
import 'package:app_calificaciones/views/periodo/periodo_page.dart';
import 'package:app_calificaciones/views/estudiante/estudiante_page.dart';
import 'package:app_calificaciones/views/funcionario/funcionario_page.dart';
import 'package:app_calificaciones/views/home.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../models/materia_curso_model.dart';

class Pages {
  static final List<GetPage> pages = [
    GetPage(name: Routers.LOGIN, page: () => const LoginView()),
    GetPage(name: Routers.HOME, page: () => const HomePage()),
    GetPage(
      name: Routers.CURSO,
      page: () => const CursoPage(),
    ),
    GetPage(
      name: Routers.CURSOESTUDIANTE,
      page: () => const CursoEstudiantePage(),
      arguments: const {"curso": MateriaEstudianteModel},
    ),
    GetPage(
      name: Routers.FUNCIONARIO,
      page: () => const FuncionarioPage(),
    ),
    GetPage(
      name: Routers.ESTUDIANTE,
      page: () => EstudiantePage(),
    ),
    GetPage(
      name: Routers.PERIODO,
      page: () => const PeriodoPage(),
    ),
    GetPage(
      name: Routers.MATERIACURSODOCENTE,
      page: () => const MateriaCursoDocentePeriodoPage(),
    ),
    GetPage(
      name: Routers.MATERIA,
      page: () => const MateriaPage(),
    ),
    GetPage(
      name: Routers.PERIODOCURSO,
      page: () => const CursosPeriodoPage(),
    ),
    GetPage(
      name: Routers.DOCENTEMATERIAS,
      page: () => const DocenteCurso(),
    )
  ];
}
