import 'package:app_calificaciones/controller/curso_periodo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../router/router.dart';
import '../../utils/drawer.dart';

class CursosPeriodoPage extends StatelessWidget {
  const CursosPeriodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CursoPeriodoController(),
      builder: (controller) {
        return Scaffold(
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
          body: Align(
            alignment: Alignment.center,
            child: controller.obx(
              (data) => Column(
                children: [
                  SizedBox(
                    width: 150,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: const Text("Periodo: "),
                        ),
                        GetBuilder(
                          init: CursoPeriodoController(),
                          id: "idPeriodoSelected",
                          builder: (controller) => DropdownButton(
                            value: controller.periodo,
                            items: controller.periodos
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.periodo.toString(),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) async {
                              controller.update(['idPeriodoSelected']);
                              // ignore: invalid_use_of_protected_member
                              controller.change(controller.lists,
                                  status: RxStatus.loading());
                              controller.periodo = value;
                              await controller.getCursosPeriodo();
                              // ignore: invalid_use_of_protected_member
                              controller.change(controller.lists,
                                  status: RxStatus.success());
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  DataTable(
                    sortAscending: true,
                    sortColumnIndex: 1,
                    columnSpacing: 35.0,
                    showCheckboxColumn: true,
                    headingRowColor: const MaterialStatePropertyAll(
                        Color.fromARGB(255, 1, 54, 96)),
                    columns: const [
                      DataColumn(
                        label: Text(
                          "Curso",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Paralelo",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Docente",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Materia",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(""),
                      ),
                    ],
                    rows: data!
                        .map(
                          (e) => DataRow(
                            cells: [
                              DataCell(
                                Text("${e.curso!.nombre}"),
                              ),
                              DataCell(
                                Text("${e.curso!.paralelo!['nombre']}"),
                              ),
                              DataCell(
                                Text("${e.docente!.nombre}"),
                              ),
                              DataCell(
                                Text("${e.materia!.nombre}"),
                              ),
                              DataCell(
                                ElevatedButton(
                                  onPressed: () {
                                    Get.offAllNamed(Routers.CURSOESTUDIANTE,
                                        arguments: {"curso": e});
                                  },
                                  child: const Text("Ver estudiantes"),
                                ),
                              )
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
