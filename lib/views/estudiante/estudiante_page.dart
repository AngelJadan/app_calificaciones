// ignore_for_file: unnecessary_null_comparison

import 'package:app_calificaciones/controller/estudiante_controller.dart';
import 'package:app_calificaciones/models/estudiante_model.dart';
import 'package:app_calificaciones/router/router.dart';
import 'package:app_calificaciones/utils/drawer.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class EstudiantePage extends GetResponsiveView<EstudianteController> {
  EstudiantePage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = context.mediaQuerySize.width;
    var height = context.mediaQuerySize.height;
    return controller.obx(
      (state) => Scaffold(
        appBar: AppBar(
          title: IconButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(Get.context!, Routers.HOME),
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
          child: Container(
            width: width,
            height: height,
            margin: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: controller.obx(
                  (state) => SizedBox(
                    width: width,
                    height: height * 0.7,
                    child: DataTable2(
                      showCheckboxColumn: false,
                      columns: const [
                        DataColumn(
                          label: Text("#"),
                        ),
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
                          label: Text("Tipo identificación"),
                        ),
                        DataColumn(
                          label: Text("Fecha nacimiento"),
                        ),
                        DataColumn(
                          label: Text(""),
                        ),
                      ],
                      rows: controller.lists
                          .map((e) => controller.mappingList(e))
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            dialogEstudiante(null);
          },
          child: const Icon(
            Icons.person_add_alt_1,
            color: Colors.green,
          ),
        ),
      ),
      onLoading: const Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  dialogEstudiante(EstudianteModel? estudiante) {
    if (estudiante != null) {
      controller.object.value = estudiante;
    }
    TextEditingController nombreController = TextEditingController(
        text: estudiante != null ? estudiante.nombre : "");
    TextEditingController apellidoController = TextEditingController(
        text: estudiante != null ? estudiante.apellido : "");
    TextEditingController(text: estudiante != null ? estudiante.apellido : "");

    TextEditingController identificacionController = TextEditingController(
        text: estudiante != null ? estudiante.identificacion : "");

    TextEditingController correoController = TextEditingController(
        text: estudiante != null ? estudiante.correo : "");

    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
            estudiante != null ? "Actualizar estudiante" : "Nuevo estudiante"),
        content: Container(
          margin: const EdgeInsets.all(10),
          child: Form(
            key: controller.formKeyCliente,
            child: Column(
              children: [
                TextFormField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    label: Text("Nombre"),
                  ),
                  maxLength: 200,
                  validator: (value) => value!.isEmpty ? "(*)" : null,
                ),
                TextFormField(
                  controller: apellidoController,
                  decoration: const InputDecoration(
                    label: Text("Apellido"),
                  ),
                  maxLength: 200,
                  validator: (value) => value!.isEmpty ? "(*)" : null,
                ),
                GetBuilder(
                  init: EstudianteController(),
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
                  init: EstudianteController(),
                  id: "idTipoDoc",
                  builder: (_) => TextFormField(
                    controller: identificacionController,
                    decoration: const InputDecoration(
                      label: Text("Identificacion(cedula/pasaporte)"),
                    ),
                    maxLength:
                        controller.documentoSeleccionado == "Cedula" ? 10 : 20,
                    validator: (value) => value!.isEmpty ? "(*)" : null,
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
                        "${controller.object.value.fechaNacimiento!.year}/${controller.object.value.fechaNacimiento!.month}/${controller.object.value.fechaNacimiento!.day}",
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: correoController,
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
          Container(
            margin: const EdgeInsets.all(5),
            child: ElevatedButton(
              onPressed: () {
                if (controller.formKeyCliente.currentState!.validate()) {
                  // ignore: unrelated_type_equality_checks
                  if (controller.object.value.fechaNacimiento ==
                      controller.now) {
                    Fluttertoast.showToast(
                      msg: "La fecha de nacimiento no puede ser la actual.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                      webPosition: "center",
                    );
                  }
                  EstudianteModel newEstudiante = EstudianteModel();
                  newEstudiante.id = estudiante?.id;
                  newEstudiante.nombre = nombreController.text;
                  newEstudiante.apellido = apellidoController.text;
                  newEstudiante.identificacion = identificacionController.text;
                  newEstudiante.tipoIdetificacion =
                      controller.documentoSeleccionado == "Cedula" ? "1" : "2";
                  newEstudiante.nombreUsuario = newEstudiante.identificacion;
                  newEstudiante.correo = correoController.text;
                  newEstudiante.fechaNacimiento =
                      controller.object.value.fechaNacimiento;

                  controller.saveEstudiante(estudiante?.id, newEstudiante);
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text(
                "Guardar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
