import 'package:app_calificaciones/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

menuDocente(BuildContext context) {
  return ExpansionTile(
    leading: const Icon(Icons.settings),
    title: const Text(
      "Curso",
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    children: [
      ListTile(
        leading: const Icon(Icons.line_style_outlined),
        title: const Text('Mis cursos'),
        onTap: () {
          Get.offAllNamed(Routers.DOCENTEMATERIAS);
        },
      ),
    ],
  );
}

menuSecretaria(BuildContext context) {
  return ExpansionTile(
    leading: const Icon(Icons.settings),
    title: const Text(
      "Opciones",
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    children: [
      ListTile(
        leading: const Icon(Icons.add_box_outlined),
        title: const Text('Materias'),
        onTap: () {
          Get.offAllNamed(Routers.MATERIA);
        },
      ),
      ListTile(
        leading: const Icon(Icons.person_add),
        title: const Text('Cursos'),
        onTap: () {
          Get.offAllNamed(Routers.CURSO);
        },
      ),
      ListTile(
        leading: const Icon(Icons.person_add),
        title: const Text('Personal'),
        onTap: () {
          Get.offAllNamed(Routers.FUNCIONARIO);
        },
      ),
      ListTile(
        leading: const Icon(Icons.person_add),
        title: const Text('Estudiantes'),
        onTap: () {
          Get.offAllNamed(Routers.ESTUDIANTE);
        },
      ),
      ListTile(
        leading: const Icon(Icons.settings_applications),
        title: const Text('Periodos'),
        onTap: () {
          Get.toNamed(Routers.PERIODO);
        },
      ),
      ListTile(
        leading: const Icon(Icons.settings_applications),
        title: const Text('Materias de periodos'),
        onTap: () {
          Get.toNamed(Routers.PERIODO);
        },
      ),
      ListTile(
        leading: const Icon(Icons.settings_accessibility),
        title: const Text('Materias estudiantes.'),
        onTap: () {
          Get.toNamed(Routers.MATERIACURSODOCENTE);
        },
      ),
    ],
  );
}

menuRector(BuildContext context) {
  debugPrint("rector");
  return ExpansionTile(
    leading: const Icon(Icons.settings),
    title: const Text(
      "Opciones",
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    children: [
      ListTile(
        leading: const Icon(Icons.person_add),
        title: const Text('Cursos'),
        onTap: () {
          Get.offAllNamed(Routers.CURSO);
        },
      ),
      ListTile(
        leading: const Icon(Icons.person_add),
        title: const Text('Personal'),
        onTap: () {
          Get.offAllNamed(Routers.FUNCIONARIO);
        },
      ),
      ListTile(
        leading: const Icon(Icons.person_add),
        title: const Text('Estudiantes'),
        onTap: () {
          Get.offAllNamed(Routers.ESTUDIANTE);
        },
      ),
    ],
  );
}

estudiantes(BuildContext context) {
  return ExpansionTile(
    leading: const Icon(
      Icons.settings,
    ),
    title: const Text(
      "Curso",
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_add),
                    title: const Text('Cursos'),
                    onTap: () {
                      Get.offAllNamed(Routers.CURSO);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_add),
                    title: const Text('Estudiantes'),
                    onTap: () {
                      Get.offAllNamed(Routers.ESTUDIANTE);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

funcionarios(BuildContext context) {
  return ExpansionTile(
    leading: const Icon(
      Icons.settings,
    ),
    title: const Text(
      "Funcionarios",
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_add),
                    title: const Text('Funcionario'),
                    onTap: () {
                      Get.offAllNamed(Routers.FUNCIONARIO);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
