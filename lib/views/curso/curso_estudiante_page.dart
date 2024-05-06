import 'package:app_calificaciones/router/router.dart';
import 'package:app_calificaciones/utils/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/curso_controller.dart';

class CursoEstudiantePage extends StatelessWidget {
  const CursoEstudiantePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CursoController(),
      builder: (controller) => Center(
        child: controller.loading.value
            ? MaterialApp(
                debugShowCheckedModeBanner: false,
                builder: (context, child) {
                  return const SizedBox(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              )
            : Scaffold(
                appBar: AppBar(
                  title: IconButton(
                    onPressed: () => Get.offAllNamed(Routers.HOME),
                    icon: const SizedBox(
                      width: 50,
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios),
                          Icon(
                            Icons.home,
                          )
                        ],
                      ),
                    ),
                    tooltip: "Inicio",
                  ),
                ),
                drawer: getDrawer(Get.context!),
                body: Text("dd"),
              ),
      ),
    );
  }
}
