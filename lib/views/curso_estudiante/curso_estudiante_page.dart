// ignore_for_file: use_key_in_widget_constructors

import 'package:app_calificaciones/controller/curso_estudiante_controller.dart';
import 'package:app_calificaciones/router/router.dart';
import 'package:app_calificaciones/utils/drawer.dart';
import 'package:app_calificaciones/utils/injection.dart';
import 'package:app_calificaciones/views/curso_estudiante/calificaciones_page.dart';
import 'package:app_calificaciones/views/curso_estudiante/view_curso_estudiante_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CursoEstudiantePage extends StatelessWidget {
  const CursoEstudiantePage();

  @override
  Widget build(BuildContext context) {
    Injection.init();
    return GetBuilder(
      init: CursoEstudianteController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: IconButton(
            onPressed: () => Get.offAllNamed(Routers.PERIODOCURSO),
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
        body: Center(
          child: controller.obx(
            (data) => Container(
              margin: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    controller.materiaCursoDocente != null
                        ? SizedBox(
                            width: 150,
                            child: controller.materiaCursoDocente != null
                                ? Text(
                                    "${controller.materiaCursoDocente!.curso!.nombre} ${controller.materiaCursoDocente!.curso!.paralelo!['nombre']}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                : const Text(""))
                        : const Text(""),
                    viewDataCalificaciones(controller, context)
                  ],
                ),
              ),
            ),
            onLoading: const CircularProgressIndicator(),
            onEmpty: const Text("Sin datos"),
            onError: (error) => Text("ERROR: $error"),
          ),
        ),
        floatingActionButton: IconButton.filled(
          onPressed: () {
            viewCursoEstudiante(null, controller, context);
          },
          icon: const Icon(
            Icons.add,
          ),
          tooltip: "Crear",
        ),
      ),
    );
  }
}
