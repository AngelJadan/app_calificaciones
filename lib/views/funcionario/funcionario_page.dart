import 'dart:js';

import 'package:app_calificaciones/controller/abstract_controller.dart';
import 'package:app_calificaciones/controller/funcionario_controller.dart';
import 'package:app_calificaciones/router/router.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:provider/provider.dart';

import '../../utils/drawer.dart';

class FuncionarioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: FuncionarioController(),
      builder: (controller) => Center(
        child: controller.loading
            ? const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  title: IconButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                        Get.context!, Routers.HOME),
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
                  child: controller.lists.isEmpty
                      ? const Text("Aun sin datos.")
                      : Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 4, 5, 4),
                            child: DataTable2(
                                columnSpacing: 12,
                                horizontalMargin: 12,
                                minWidth: 50,
                                columns: const [
                                  DataColumn(
                                    label: Text("Nombre"),
                                  ),
                                  DataColumn(
                                    label: Text("Apellido"),
                                  ),
                                  DataColumn(
                                    label: Text("Correo"),
                                  ),
                                  DataColumn(
                                    label: Text("Identificacion"),
                                  ),
                                  DataColumn(
                                    label: Text("Fecha ingreso"),
                                  ),
                                ],
                                rows: controller.lists
                                    .map(
                                      (e) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(e.nombre.toString()),
                                          ),
                                          DataCell(
                                            Text(e.apellido.toString()),
                                          ),
                                          DataCell(
                                            Text(e.correo.toString()),
                                          ),
                                          DataCell(
                                            Text(e.identificacion.toString()),
                                          ),
                                          DataCell(
                                            Text(
                                                "${e.fechaIngreso!.year}/${e.fechaIngreso!.month}/${e.fechaIngreso!.day}"),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList()),
                          ),
                        ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    newFuncionario(controller);
                  },
                  tooltip: "Crear nuevo funcionario",
                  child: const Icon(
                    Icons.person_add_alt_1,
                    color: Colors.green,
                  ),
                ),
              ),
      ),
    );
  }

  newFuncionario(FuncionarioController controller) {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Nuevo funcionario"),
        content: Form(
          key: controller.formKeyCliente,
          child: Column(
            children: [
              TextFormField(
                controller: controller.nombreController,
                decoration: const InputDecoration(
                  label: Text("Nombre"),
                ),
                maxLength: 200,
                validator: (value) => value!.isEmpty ? "(*)" : null,
              ),
              TextFormField(
                controller: controller.apellidoController,
                decoration: const InputDecoration(
                  label: Text("Apellido"),
                ),
                maxLength: 200,
                validator: (value) => value!.isEmpty ? "(*)" : null,
              ),
              GetBuilder(
                init: FuncionarioController(),
                id: "idTipoDoc",
                builder: (_) => DropdownButton<String>(
                  value: controller.documentoSeleccionado,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    controller.selectTipoDocumento(value!);
                  },
                  items: controller.tipoDocumentos
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              GetBuilder(
                init: FuncionarioController(),
                id: "idTipoDoc",
                builder: (_) => TextFormField(
                  controller: controller.identificacionController,
                  decoration: const InputDecoration(
                    label: Text("Identificacion(cedula/pasaporte)"),
                  ),
                  maxLength:
                      controller.documentoSeleccionado == "Cedula" ? 10 : 20,
                  validator: (value) => value!.isEmpty ? "(*)" : null,
                ),
              ),
              GetBuilder(
                init: FuncionarioController(),
                id: "idTipoFuncionario",
                builder: (_) => DropdownButton<String>(
                  value: controller.object.value.tipo,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    controller.object.value.tipo = value;
                    controller.update(['idTipoFuncionario']);
                  },
                  items: ['1', '2', '3']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(controller.object.value.getTipo(value)),
                    );
                  }).toList(),
                ),
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      controller.chooseDateInit();
                    },
                    icon: const Icon(Icons.calendar_month),
                    label: const Text("Fecha de ingreso"),
                  ),
                  Obx(
                    () => Text(
                      "${controller.object.value.fechaIngreso!.year}/${controller.object.value.fechaIngreso!.month}/${controller.object.value.fechaIngreso!.day}",
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: controller.correoController,
                decoration: const InputDecoration(
                  label: Text("Correo electronico"),
                ),
                maxLength: 200,
                validator: (value) {
                  return (value!.isEmpty ||
                          !RegExp(r'^[^@]+@[^@]+\.[a-zA-Z]{2,}$')
                              .hasMatch(value))
                      ? "Ingrese un correo valido"
                      : null;
                },
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (controller.formKeyCliente.currentState!.validate()) {
                if (controller.object.value.tipo == "1") {
                  if (controller.object.value.validarCedula(
                      controller.identificacionController.text)) {
                    controller.saveFuncionario();
                  } else {
                    Get.defaultDialog(
                      title: "Error validacion cedula",
                      content: const Text(
                          "El número de cédula ingresado no es valido."),
                      onConfirm: () => Get.back(),
                    );
                  }
                } else {
                  controller.saveFuncionario();
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text(
              "Agregar",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text(
              "Cerrar",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
