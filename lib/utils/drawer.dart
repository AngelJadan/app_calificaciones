// ignore_for_file: unrelated_type_equality_checks

import 'package:app_calificaciones/router/router.dart';
import 'package:app_calificaciones/utils/injection.dart';
import 'package:app_calificaciones/utils/intems_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';

final loginController = Get.find<LoginController>();
getDrawer(BuildContext context) {
  //loginController.getPerson();
  //print(
  //    "loginController.loginModel!.tipoUsuario ${loginController.loginModel!.tipoUsuario}");
  return Drawer(
    child: FutureBuilder(
      future: loginController.getPerson(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          Injection.init();
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.amber,
                ),
                child: Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        child: Icon(
                          Icons.person,
                          size: 40,
                        ),
                      ),
                      Center(
                        child: Text(
                          loginController.loginModel!.nombre.toString(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  loginController.logout();
                },
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
                label: const Text(
                  "Cerrar sesión",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              loginController.loginModel?.tipoUsuario == "1"
                  ? menuDocente(context)
                  : loginController.loginModel!.tipoUsuario == "3"
                      ? menuSecretaria(context)
                      : loginController.loginModel!.tipoUsuario == "2"
                          ? menuRector(context)
                          : Text(loginController.loginModel!.tipoUsuario
                              .toString()),
              //estudiantes(context),
              //loginController.loginModel!.tipoUsuario == "2"
              //    ? funcionarios(context)
              //    : const Text(""),
            ],
          );
        }
      },
    ),
  );
}

getMenuGridHomeDocente(BuildContext context) {
  Injection.init();
  return Column(
    children: [
      IconButton(
        onPressed: () {
          Get.offAllNamed(Routers.DOCENTEMATERIAS);
        },
        icon: const Icon(Icons.list),
      ),
      const Text("Mis cursos y materias"),
    ],
  );
}

getMenuGridHome(BuildContext context) {
  final width = context.mediaQuery.size.width;
  Injection.init();
  return Column(
    children: [
      Row(
        children: [
          SizedBox(
            width: (width - 50) / 4,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    Get.offAllNamed(Routers.MATERIA);
                  },
                  icon: const Icon(Icons.add_box_outlined),
                  iconSize: (width * 0.1) / 4,
                ),
                const Text("Materias")
              ],
            ),
          ),
          SizedBox(
            width: (width - 50) / 4,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    Get.offAllNamed(Routers.CURSO);
                  },
                  icon: const Icon(Icons.settings),
                  iconSize: (width * 0.1) / 4,
                ),
                const Text("Cursos")
              ],
            ),
          ),
          SizedBox(
            width: (width - 50) / 4,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    Get.offAllNamed(Routers.FUNCIONARIO);
                  },
                  icon: const Icon(Icons.person),
                  iconSize: (width * 0.1) / 4,
                ),
                const Text("Funcionarios")
              ],
            ),
          ),
          SizedBox(
            width: (width - 50) / 4,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    Get.offAllNamed(Routers.ESTUDIANTE);
                  },
                  icon: const Icon(Icons.person),
                  iconSize: (width * 0.1) / 4,
                ),
                const Text("Estudiantes")
              ],
            ),
          ),
        ],
      ),
      Row(
        children: [
          SizedBox(
            width: (width - 50) / 4,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    Get.toNamed(Routers.PERIODO);
                  },
                  icon: const Icon(Icons.settings_applications),
                  iconSize: (width * 0.1) / 4,
                ),
                const Text("Periodos")
              ],
            ),
          ),
          SizedBox(
            width: (width - 50) / 4,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    Get.toNamed(Routers.PERIODOCURSO);
                  },
                  icon: const Icon(Icons.settings_applications),
                  iconSize: (width * 0.1) / 4,
                ),
                const Text("Materias de periodos")
              ],
            ),
          ),
          SizedBox(
            width: (width - 50) / 4,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    Get.toNamed(Routers.MATERIACURSODOCENTE);
                  },
                  icon: const Icon(Icons.settings_accessibility),
                  iconSize: (width * 0.1) / 4,
                ),
                const Text("Materias estudiantes.")
              ],
            ),
          ),
        ],
      )
    ],
  );
}
