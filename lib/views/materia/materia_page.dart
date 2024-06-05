import 'package:app_calificaciones/controller/materia_controller.dart';
import 'package:app_calificaciones/models/materia_model.dart';
import 'package:app_calificaciones/router/router.dart';
import 'package:app_calificaciones/utils/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';

class MateriaPage extends StatelessWidget {
  const MateriaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MateriaController(),
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
          child: controller.obx(
            (state) => Container(
              margin: const EdgeInsets.all(15),
              child: DataTable(
                sortAscending: true,
                sortColumnIndex: 1,
                columnSpacing: 35.0,
                columns: const [
                  DataColumn(
                    label: Text("Nombre"),
                  ),
                  DataColumn(
                    label: Text("Area"),
                  ),
                  DataColumn(label: Text("")),
                  DataColumn(label: Text("")),
                ],
                rows: controller.lists
                    .map(
                      (e) => DataRow(
                        cells: [
                          DataCell(
                            Text(
                              e.nombre.toString(),
                            ),
                          ),
                          DataCell(
                            Text(
                              e.area!['nombre'].toString(),
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
                                controller.delete(e);
                              },
                              icon: const Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                              tooltip: "Eliminar",
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
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

  viewUpset(MateriaModel? materia) {
    final controller = Get.find<MateriaController>();
    Map? areaSelected = materia?.area;
    final formControl = GlobalKey<FormState>();
    TextEditingController nombreController =
        TextEditingController(text: materia == null ? "" : materia.nombre);

    Color colorSelected = Colors.black;

    return showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(materia == null ? "Nueva materia" : "Actualizar materia"),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: const EdgeInsets.all(5),
              width: 350,
              child: Form(
                key: formControl,
                child: ListBody(
                  children: [
                    DropdownButton(
                      // ignore: unnecessary_null_comparison
                      hint: GetBuilder(
                        id: "idMateriaSelected",
                        init: MateriaController(),
                        builder: (_) => Text(
                          areaSelected == null
                              ? "Seleccionar area"
                              : areaSelected!["nombre"].toString(),
                          style: TextStyle(color: colorSelected),
                        ),
                      ),
                      items: controller.areas
                          .map(
                            (Map e) => DropdownMenuItem(
                              value: e,
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                child: Text(
                                  e['nombre'],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (Map? value) {
                        areaSelected = value;
                        colorSelected = Colors.black;
                        controller.update(['idMateriaSelected']);
                      },
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        validator: (value) => value!.isEmpty ? "(*)" : null,
                        controller: nombreController,
                        decoration: const InputDecoration(
                            labelText: "Nombre de materia"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (areaSelected != null) {
                  if (formControl.currentState!.validate()) {
                    controller.save(MateriaModel(
                      id: materia?.id,
                      nombre: nombreController.text,
                      area: areaSelected,
                    ));
                    Get.back();
                    if (materia!.id != null) {
                      MotionToast.success(
                        description: const Text("Materia actualizada."),
                      ).show(context);
                    } else {
                      MotionToast.success(
                        description: const Text("Materia creada."),
                      ).show(context);
                    }
                  }
                } else {
                  colorSelected = Colors.red;
                  controller.update(["idMateriaSelected"]);
                }
              },
              child: const Text("Agregar"),
            ),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        );
      },
    );
  }
}
