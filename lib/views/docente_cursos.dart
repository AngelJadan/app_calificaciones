import 'package:app_calificaciones/controller/docente_controller.dart';
import 'package:app_calificaciones/router/router.dart';
import 'package:app_calificaciones/utils/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocenteCurso extends StatelessWidget {
  const DocenteCurso({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DocenteController(),
      builder: (controller) => Scaffold(
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
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.amber),
        ),
        drawer: getDrawer(Get.context!),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: controller.obx(
              (state) => DataTable(
                showBottomBorder: true,
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => const Color.fromARGB(255, 5, 100, 178)),
                columns: const [
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        "Curso",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        "Paralelo",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        "Materia",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  DataColumn(label: Text(""))
                ],
                rows: controller.lists
                    .map(
                      (e) => DataRow(
                        cells: [
                          DataCell(
                            Text(
                              e.curso!.nombre!.toString(),
                            ),
                          ),
                          DataCell(Text(e.curso!.paralelo!['nombre'])),
                          DataCell(Text(e.materia!.nombre!)),
                          DataCell(
                            IconButton(
                              onPressed: () {
                                Get.offAllNamed(Routers.CURSOESTUDIANTE,
                                    arguments: {"curso": e});
                              },
                              tooltip: "Ver estudiantes",
                              icon: const Icon(Icons.arrow_forward_ios_sharp),
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
              onEmpty: const Text("Sin datos"),
              onLoading: const CircularProgressIndicator(),
              onError: (error) => Text(error.toString()),
            ),
          ),
        ),
      ),
    );
  }
}
