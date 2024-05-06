import 'package:app_calificaciones/controller/materia_curso_docente_controller.dart';
import 'package:app_calificaciones/utils/drawer.dart';
import 'package:app_calificaciones/views/materia_curso_docente_periodo/view_materia_curso_docente_periodo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../router/router.dart';

class MateriaCursoDocentePeriodoPage extends StatelessWidget {
  const MateriaCursoDocentePeriodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(Get.context!).width;
    var sizeHeigth = MediaQuery.sizeOf(Get.context!).height;

    return GetBuilder(
      init: MateriaCursoDocenteController(),
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
        ),
        drawer: getDrawer(Get.context!),
        body: Center(
          child: controller.obx(
            (state) => Container(
                width: size * 0.9,
                height: sizeHeigth * 0.7,
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    sortAscending: true,
                    sortColumnIndex: 1,
                    columnSpacing: 35.0,
                    showCheckboxColumn: true,
                    columns: const [
                      DataColumn(
                        label: Text(
                          "Paralelo",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Materia",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Periodo",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Docente",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(label: Text("")),
                      DataColumn(label: Text(""))
                    ],
                    rows: controller.lists
                        .map(
                          (e) => DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  e.curso!.paralelo!['nombre'],
                                ),
                              ),
                              DataCell(
                                Text(
                                  e.materia!.nombre!,
                                ),
                              ),
                              DataCell(
                                Text(
                                  e.periodo!.periodo.toString(),
                                ),
                              ),
                              DataCell(
                                Text(
                                  "${e.docente!.nombre!} ${e.docente!.apellido!}",
                                ),
                              ),
                              DataCell(
                                IconButton(
                                  onPressed: () {
                                    viewUpset(e);
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.amber,
                                  ),
                                  tooltip: "Editar",
                                ),
                              ),
                              DataCell(
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog.adaptive(
                                            title: const Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Eliminar',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            content: const Text(
                                                "¿Esta seguro de eliminar este item?"),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  controller.delete(e);
                                                  MotionToast.success(
                                                      description: const Text(
                                                          "Item eliminado correctamente."));
                                                  Get.back();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green),
                                                child: const Text("Eliminar"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () => Get.back(),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.red),
                                                child: const Text(
                                                  "Cancelar",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                  tooltip: "Eliminar",
                                ),
                              )
                            ],
                          ),
                        )
                        .toList(),
                  ),
                )),
            onEmpty: const Text("sin datos"),
            onError: (error) => Text(error.toString()),
            onLoading: const CircularProgressIndicator(),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            viewUpset(null);
          },
          label: const Icon(Icons.add),
        ),
      ),
    );
  }
}
