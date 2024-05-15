import 'package:app_calificaciones/controller/curso_estudiante_controller.dart';
import 'package:app_calificaciones/models/estudiante_model.dart';
import 'package:app_calificaciones/models/materia_curso_model.dart';
import 'package:app_calificaciones/router/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';

viewCursoEstudiante(MateriaEstudianteModel? model,
    CursoEstudianteController controller, BuildContext context) {
  String displayAutoComplete(EstudianteModel option) =>
      "${option.nombre} ${option.apellido}";
  if (controller.materiaCursoDocente == null) {
    MotionToast.error(
            description: const Text(
                "No existe un curso seleccionado, vuelva a ingresar al curso."))
        .show(context);
    Get.offAllNamed(Routers.CURSO);
  } else {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Align(
              alignment: Alignment.center,
              child: Text("Nuevo"),
            ),
            content: Column(
              children: [
                SizedBox(
                  child: Text(
                      "Curso: ${controller.materiaCursoDocente!.curso!.nombre} ${controller.materiaCursoDocente!.curso!.paralelo!['nombre']}"),
                ),
                SizedBox(
                  child: Autocomplete<EstudianteModel>(
                    displayStringForOption: displayAutoComplete,
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<EstudianteModel>.empty();
                      }
                      return controller.estudiantes
                          .where((EstudianteModel option) {
                        return option.nombre
                            .toString()
                            .contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (EstudianteModel selection) {
                      debugPrint('You just selected $selection');
                      model ??= MateriaEstudianteModel();
                      model!.estudiante = selection;
                    },
                  ),
                )
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  try {
                    if (controller.materiaCursoDocente == null) {
                      throw Exception(
                          "No hay un curso seleccionado, vuelva a ingresar.");
                    }
                    if (kDebugMode) {
                      print("model?.estudiante ${model?.estudiante}");
                    }
                    if (model?.estudiante == null) {
                      throw Exception("Seleccione un estudiante");
                    }
                    model?.materiaCursoDocente = controller.materiaCursoDocente;
                    controller.save(model!);
                  } catch (e) {
                    MotionToast.error(
                      description: Text(
                        e.toString(),
                      ),
                    ).show(context);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text(
                  "Agregar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  "Cerrar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }
}
