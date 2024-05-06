import 'package:app_calificaciones/controller/materia_curso_docente_controller.dart';
import 'package:app_calificaciones/models/curso_model.dart';
import 'package:app_calificaciones/models/materia_curso_docente_model.dart';
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
