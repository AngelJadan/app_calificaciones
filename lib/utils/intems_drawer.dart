import 'package:app_calificaciones/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

estudiantes(BuildContext context) {
  return ExpansionTile(
    leading: Icon(
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
                      Navigator.pushReplacementNamed(context, Routers.CURSO);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_add),
                    title: const Text('Estudiantes'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, Routers.CURSO);
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
