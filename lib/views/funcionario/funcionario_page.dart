import 'package:app_calificaciones/controller/funcionario_controller.dart';
import 'package:app_calificaciones/models/persona_model.dart';
import 'package:app_calificaciones/router/router.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../utils/drawer.dart';

class FuncionarioPage extends StatelessWidget {
  const FuncionarioPage({super.key});

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
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(12, 4, 5, 4),
                          child: DataTable2(
                            columnSpacing: 12,
                            horizontalMargin: 12,
                            minWidth: 50,
                            showCheckboxColumn: false,
                            columns: const [
                              DataColumn(
                                label: Text(
                                  "#",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Nombre",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Apellido",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Identificacion",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Correo",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Fecha ingreso",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Tipo de funcionario",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Acción",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                            rows: controller.lists
                                .map(
                                  (e) => controller.mapping(e),
                                )
                                .toList(),
                          ),
                        ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    newFuncionario(null);
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

  newFuncionario(PersonaModel? funcionario) {
    var controller = Get.find<FuncionarioController>();
    if (funcionario != null) {
      controller.object.value.id = funcionario.id;
      controller.nombreController.text = funcionario.nombre.toString();
      controller.apellidoController.text = funcionario.apellido.toString();
      controller.selectTipoDocumento(
          funcionario.tipoIdetificacion == "1" ? "Cedula" : "Pasaporte");
      controller.object.value.tipo = funcionario.tipo;
      controller.identificacionController.text = funcionario.identificacion!;
      controller.object.value.fechaIngreso = funcionario.fechaIngreso;
      controller.correoController.text = funcionario.correo!;
    }
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Nuevo funcionario"),
        content: Form(
          key: controller.formKeyCliente,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              debugPrint("inicia validar formulario");
              if (controller.formKeyCliente.currentState!.validate()) {
                debugPrint(
                    "paso validacion formulario: ${controller.object.value.tipo}");
                if (controller.object.value.tipoIdetificacion == "Cedula") {
                  debugPrint("es cedula");
                  if (controller.object.value.validarCedula(
                          controller.identificacionController.text) ==
                      true) {
                    debugPrint("inicia registro funcionario");
                    controller.saveFuncionario();
                    Get.back();
                  } else {
                    debugPrint("cedula incorrecta");
                    MotionToast.error(
                      description: const Text(
                          "El número de cedula recibido no es valido"),
                    ).show(context);
                  }
                } else {
                  controller.saveFuncionario();
                  Get.back();
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text(
              "Guardar",
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
