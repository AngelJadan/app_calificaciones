import 'package:app_calificaciones/controller/home_controller.dart';
import 'package:app_calificaciones/models/login_model.dart';
import 'package:app_calificaciones/router/router.dart';
import 'package:app_calificaciones/utils/intems_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';

getDrawer(BuildContext context) {
  final loginController = Get.find<LoginController>();

  //loginController.getPerson();
  //print(
  //    "loginController.loginModel.tipoUsuario ${loginController.loginModel.tipoUsuario}");
  return Drawer(
      child: FutureBuilder(
          future: loginController.getPerson(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
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
                              loginController.loginModel.nombre.toString(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.offAllNamed(Routers.LOGIN);
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
                  estudiantes(context),
                  loginController.loginModel.tipoUsuario == "2"
                      ? funcionarios(context)
                      : const Text(""),
                ],
              );
            }
          }));
}
