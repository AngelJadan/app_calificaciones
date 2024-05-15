import 'package:app_calificaciones/controller/materia_curso_docente_controller.dart';
import 'package:app_calificaciones/models/curso_model.dart';
import 'package:app_calificaciones/models/estudiante_model.dart';
import 'package:app_calificaciones/models/materia_curso_docente_model.dart';
import 'package:app_calificaciones/models/materia_curso_model.dart';
import 'package:app_calificaciones/models/materia_model.dart';
import 'package:app_calificaciones/models/persona_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';

Future<void> viewUpset(MateriaCursoDocente? object) async {
  final controller = Get.find<MateriaCursoDocenteController>();

  MateriaModel? materiaSelected = object?.materia;
  CursoModel? cursoSelected = object?.curso;
  PersonaModel? docenteSelected = object?.docente;

  Color colorMateria = Colors.black;
  Color colorCurso = Colors.black;
  Color colorDocente = Colors.black;

  return showDialog(
    barrierDismissible: false,
    context: Get.context!,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Align(
          alignment: Alignment.center,
          child: Text(object == null ? "Nuevo" : "Actualizar"),
        ),
        content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                margin: const EdgeInsets.all(5),
                width: 350,
                child: ListBody(
                  children: [
                    Text(
                      "Periodo: ${controller.periodo!.periodo.toString()}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    DropdownButton(
                      // ignore: unnecessary_null_comparison
                      hint: GetBuilder(
                        id: "idMateriaSelected",
                        init: MateriaCursoDocenteController(),
                        builder: (controller) => Text(
                          materiaSelected == null
                              ? "Seleccionar materia"
                              : "${materiaSelected!.nombre}",
                          style: TextStyle(color: colorMateria),
                        ),
                      ),
                      items: controller.materias
                          .map(
                            (MateriaModel e) => DropdownMenuItem(
                              value: e,
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                child: Text(
                                  "${e.nombre} | ${e.area!['nombre']}",
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (MateriaModel? value) {
                        materiaSelected = value;
                        colorMateria = Colors.black;
                        controller.update(['idMateriaSelected']);
                      },
                    ),
                    DropdownButton(
                      // ignore: unnecessary_null_comparison
                      hint: GetBuilder(
                        id: "idCursoSelected",
                        init: MateriaCursoDocenteController(),
                        builder: (controller) => Text(
                          cursoSelected == null
                              ? "Seleccionar curso"
                              : "${cursoSelected!.nombre} : ${cursoSelected!.paralelo!['nombre']}",
                          style: TextStyle(color: colorCurso),
                        ),
                      ),
                      items: controller.cursos
                          .map(
                            (CursoModel e) => DropdownMenuItem(
                              value: e,
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                child: Text(
                                  "Nivel: ${e.nivel}, Curso: ${e.nombre}, Paralelo: ${e.paralelo!['nombre']}",
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (CursoModel? value) {
                        cursoSelected = value;
                        colorCurso = Colors.black;
                        controller.update(['idCursoSelected']);
                      },
                    ),
                    DropdownButton(
                      // ignore: unnecessary_null_comparison
                      hint: GetBuilder(
                        id: "idDocenteSelected",
                        init: MateriaCursoDocenteController(),
                        // ignore: unnecessary_null_comparison
                        builder: (controller) => Text(
                          docenteSelected == null
                              ? "Seleccionar docente"
                              : "${docenteSelected!.nombre} ${docenteSelected!.apellido}",
                          style: TextStyle(color: colorDocente),
                        ),
                      ),
                      items: controller.docentes
                          .map(
                            (PersonaModel e) => DropdownMenuItem(
                              value: e,
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                child: Text(
                                  "${e.nombre} ${e.apellido}",
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (PersonaModel? value) {
                        docenteSelected = value;
                        colorDocente = Colors.black;
                        controller.update(['idDocenteSelected']);
                      },
                    ),
                  ],
                ),
              ),
            )),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (materiaSelected != null) {
                if (cursoSelected != null) {
                  if (docenteSelected != null) {
                    controller.save(MateriaCursoDocente(
                      id: object?.id,
                      curso: cursoSelected,
                      materia: materiaSelected,
                      periodo: controller.periodo,
                      docente: docenteSelected,
                    ));
                    if (object?.id == null) {
                      MotionToast.success(
                              description:
                                  const Text("Item agregado correctamente"))
                          .show(context);
                    }
                    if (object?.id == null) {
                      MotionToast.success(
                              description:
                                  const Text("Item actualizado correctamente"))
                          .show(context);
                    }
                    Get.back();
                  } else {
                    colorDocente = Colors.red;
                    controller.update(['idDocenteSelected']);
                  }
                } else {
                  colorCurso = Colors.red;
                  controller.update(['idCursoSelected']);
                }
              } else {
                colorMateria = Colors.red;
                controller.update(['idMateriaSelected']);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text(
              "Agregar",
              style: TextStyle(color: Colors.white),
            ),
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

addEstudiante(MateriaCursoDocente materiaCurso) {
  EstudianteModel estudianteModel = EstudianteModel();
  final controller = Get.find<MateriaCursoDocenteController>();
  String displayStringForOption(EstudianteModel estudiante) =>
      "${estudiante.nombre} ${estudiante.apellido}";
  return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Align(
            child: Text("Nuevo estudiante"),
          ),
          content: Align(
            child: Column(
              children: [
                SizedBox(
                  width: 200,
                  child: Row(
                    children: [
                      const Text("Curso: "),
                      Text(
                          "${materiaCurso.curso!.nombre!} ${materiaCurso.curso!.paralelo!['nombre']}"),
                    ],
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Row(
                    children: [
                      const Text("Materia: "),
                      Text("${materiaCurso.materia!.nombre}")
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Text("Estudiante: "),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: Autocomplete<EstudianteModel>(
                        displayStringForOption: displayStringForOption,
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == "") {
                            return const Iterable<EstudianteModel>.empty();
                          }
                          return controller.estudiantes!.where(
                            (EstudianteModel element) {
                              return element.identificacion!
                                  .toString()
                                  .contains(textEditingValue.text);
                            },
                          );
                        },
                        onSelected: (EstudianteModel estudianteSelected) {
                          estudianteModel = estudianteSelected;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                MateriaEstudianteModel materiaEstudiante =
                    MateriaEstudianteModel(
                        materiaCursoDocente: materiaCurso,
                        estudiante: estudianteModel);
                try {
                  controller.validarEstudianteAgregar(materiaEstudiante);
                  MateriaEstudianteModel? result =
                      await controller.agregarEstudiante(materiaEstudiante);
                  materiaCurso.estudiantes?.add(result!);
                  Get.back();
                  MotionToast.success(
                          description:
                              const Text("Estudiante agregado al curso."))
                      // ignore: use_build_context_synchronously
                      .show(context);
                } catch (e) {
                  MotionToast.error(description: Text(e.toString()))
                      // ignore: use_build_context_synchronously
                      .show(context);
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text(
                "Agregar",
                style: TextStyle(color: Colors.white),
              ),
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
      });
}

listEstudiantes(List<MateriaEstudianteModel> lista) {
  return showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Lista de estudiantes de la materia"),
          content: GetBuilder(
            init: MateriaCursoDocenteController(),
            id: "idLisEstudiantes",
            builder: (controller) => SizedBox(
              width: 200,
              child: lista.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.all(5),
                      itemCount: lista.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          height: 35,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 25,
                                child: Text("${index + 1} | "),
                              ),
                              SizedBox(
                                width: 280,
                                child: Text(
                                  "${lista[index].estudiante!.nombre!} ${lista[index].estudiante!.apellido}",
                                  maxLines: 3,
                                ),
                              ),
                              SizedBox(
                                child: IconButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: "¡Eliminar!",
                                      titleStyle:
                                          const TextStyle(color: Colors.red),
                                      content: Text(
                                        "¿Esta seguro de eliminar al estudiante ${lista[index].estudiante!.nombre} ${lista[index].estudiante!.nombre} de esta materia?",
                                        maxLines: 5,
                                      ),
                                      confirm: ElevatedButton(
                                        onPressed: () async {
                                          try {
                                            await controller
                                                .eliminarEstudianteMateria(
                                                    lista[index]);

                                            lista.removeWhere((element) =>
                                                element.estudiante ==
                                                lista[index].estudiante);
                                            controller
                                                .update(["idLisEstudiantes"]);
                                            MotionToast.success(
                                                    description: const Text(
                                                        "Estudiante quitado satisfactoriamente de la materia."))
                                                // ignore: use_build_context_synchronously
                                                .show(context);
                                            Get.back();
                                          } catch (e) {
                                            MotionToast.error(
                                                    description:
                                                        Text(e.toString()))
                                                // ignore: use_build_context_synchronously
                                                .show(context);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                        ),
                                        child: const Text(
                                          "Confirmar",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      cancel: ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        child: const Text(
                                          "Cerrar",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.person_remove,
                                    color: Colors.red,
                                  ),
                                  tooltip: "Eliminar",
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )
                  : const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Sin estudiantes registrados.",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Get.back();
              },
              child: const Text(
                "Cerrar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      });
}
