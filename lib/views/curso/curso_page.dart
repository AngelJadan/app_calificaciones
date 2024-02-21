import 'package:app_calificaciones/controller/curso_controller.dart';
import 'package:app_calificaciones/router/router.dart';
import 'package:app_calificaciones/utils/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*
  {
      "email": "jperez@mail.com",
      "password": "cuenca2023.$"
  }
*/

class CursoPage extends StatelessWidget {
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
                    onPressed: () => Get.offAllNamed(Routers.CURSO),
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
                  child: controller.cursos.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.all(50),
                          child: ListView.builder(
                            itemCount: controller.cursos.length,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return ListTile(
                                    title: Column(
                                  children: [
                                    const Row(
                                      children: [
                                        SizedBox(
                                          width: 130,
                                          child: Center(
                                            child: Text(
                                              "Nivel",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 250,
                                          child: Text(
                                            "Nombre",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            "Paralelo",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 120,
                                          child: Text(
                                              controller.cursos[index].nivel ==
                                                      1
                                                  ? "Educacion basica general"
                                                  : "Bachillerato"),
                                        ),
                                        SizedBox(
                                          width: 250,
                                          child: Text(
                                            controller.cursos[index].nombre
                                                .toString(),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            controller.cursos[index]
                                                .paralelo!['nombre']
                                                .toString(),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 50,
                                          child: IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                  title: const Text("Eliminar"),
                                                  content: const Text(
                                                      "¿Esta seguro de eliminar este curso?"),
                                                  actions: [
                                                    IconButton(
                                                      onPressed: () {
                                                        controller.deleteCurso(
                                                            controller
                                                                .cursos[index]);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      icon: const Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                  actionsAlignment:
                                                      MainAxisAlignment.center,
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.remove_circle,
                                              color: Color.fromARGB(
                                                  255, 201, 18, 5),
                                            ),
                                            tooltip: "Eliminar",
                                          ),
                                        ),
                                        SizedBox(
                                          width: 50,
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.people,
                                              color: Colors.green,
                                            ),
                                            tooltip: "Estudiantes",
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ));
                              } else {
                                return ListTile(
                                  title: Row(
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        child: Text(
                                            // ignore: unrelated_type_equality_checks
                                            controller.cursos[index].nivel == 1
                                                ? "Educacion basica general"
                                                : "Bachillerato"),
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          controller.cursos[index].nombre
                                              .toString(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          controller
                                              .cursos[index].paralelo!['nombre']
                                              .toString(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        child: IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title: const Text("Eliminar"),
                                                content: const Text(
                                                    "¿Esta seguro de eliminar este curso?"),
                                                actions: [
                                                  IconButton(
                                                    onPressed: () {
                                                      controller.deleteCurso(
                                                          controller
                                                              .cursos[index]);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    icon: const Icon(
                                                      Icons.check,
                                                      color: Colors.green,
                                                    ),
                                                    tooltip: "Confirmar",
                                                  ),
                                                  IconButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    icon: const Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    ),
                                                    tooltip: "Cancelar",
                                                  )
                                                ],
                                                actionsAlignment:
                                                    MainAxisAlignment.center,
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.remove_circle,
                                            color:
                                                Color.fromARGB(255, 201, 18, 5),
                                          ),
                                          tooltip: "Eliminar",
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.people,
                                            color: Colors.green,
                                          ),
                                          tooltip: "Estudiantes",
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        )
                      : const Text(
                          "Sin cursos registrados",
                          style: TextStyle(
                            color: Color.fromARGB(255, 141, 11, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    newCurso(controller);
                  },
                  tooltip: "Crear nuevo curso",
                  child: const Icon(
                    Icons.add_box_rounded,
                  ),
                ),
              ),
      ),
    );
  }

  void newCurso(CursoController controller) {
    controller.clean();
    var paralelos = controller.paralelos;
    var size = MediaQuery.sizeOf(Get.context!).width;
    final formKey = GlobalKey<FormState>();
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Nuevo curso"),
        content: Container(
          width: size > 500 ? 500 : size,
          margin: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  maxLength: 20,
                  decoration: const InputDecoration(
                    label: Text("Nombre de curso"),
                  ),
                  controller: controller.nombreCurso,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "(*)";
                    }
                    return null;
                  },
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 100,
                        child: Text("Nivel: "),
                      ),
                      GetBuilder(
                        init: CursoController(),
                        id: "idNivelSelected",
                        builder: (_) => DropdownButton<String>(
                          value: controller.nivelSelected,
                          items: ['Basico', 'Bachillerato']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value.toString(),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            controller.setNivel(value!);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 100,
                        child: Text("Paralelo: "),
                      ),
                      GetBuilder(
                        init: CursoController(),
                        id: "idParaleloSelected",
                        builder: (_) => DropdownButton(
                          value: controller.curso.paralelo,
                          items: paralelos.map<DropdownMenuItem<Map>>(
                            (Map value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value["nombre"],
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            controller.setParalelo(value!);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.of(context).pop();
                controller.saveCurso();
              }
            },
            child: const Text(
              "Guardar",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Cancelar",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
