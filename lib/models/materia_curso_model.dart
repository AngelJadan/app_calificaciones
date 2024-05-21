import 'package:app_calificaciones/models/abstract_model.dart';
import 'package:app_calificaciones/models/calificacion_estudiante/cabecera_actividad_model.dart';
import 'package:app_calificaciones/models/calificacion_estudiante/estudiante_materia_models.dart';
import 'package:app_calificaciones/models/calificacion_estudiante/trimestre_cabecera_model.dart';
import 'package:app_calificaciones/models/estudiante_model.dart';
import 'package:app_calificaciones/models/materia_curso_docente_model.dart';
import 'package:app_calificaciones/services/remote/cabecera_trimestre_service.dart';
import 'package:flutter/material.dart';

class MateriaEstudianteModel extends AbstractModel<int> {
  MateriaEstudianteModel({
    id,
    this.estudiante,
    this.materiaCursoDocente,
    this.materiaEstudiantes,
    this.trimestres,
  }) : super(id);

  EstudianteModel? estudiante;
  MateriaCursoDocente? materiaCursoDocente;
  List<EstudianteMateriaModel>? materiaEstudiantes;
  List<CabeceraTrimestreModel>? trimestres;

  CabeceraTrimestreModel getPrimerTrimestre() {
    debugPrint("trimestres: $trimestres");
    return trimestres!.isNotEmpty
        ? trimestres!
                .where((element) => element.numeroTrimestre == 1)
                .isNotEmpty
            ? trimestres!.where((element) => element.numeroTrimestre == 1).first
            : CabeceraTrimestreModel(detalleTrimestre: [])
        : CabeceraTrimestreModel(detalleTrimestre: []);
  }

  CabeceraTrimestreModel getCabeceraTrimestre1() {
    debugPrint("obteniendo trimestre");
    debugPrint("materiaEstudiantes: $materiaEstudiantes");
    var materiaEstudiante = materiaEstudiantes!.first;
    debugPrint("materiaEstudiante: $materiaEstudiante");

    return materiaEstudiantes!.first.cabeceraTrimestre!
        .where((element) => element.numeroTrimestre == 1)
        .first;
  }

  CabeceraTrimestreModel getCabeceraTrimestre2() {
    return materiaEstudiantes!.first.cabeceraTrimestre!
        .where((element) => element.numeroTrimestre == 2)
        .first;
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "estudiante": estudiante!.id,
        "materia_curso": materiaCursoDocente!.id,
      };

  factory MateriaEstudianteModel.fromMap(Map<String, dynamic> json) {
    //debugPrint("json: $json");

    List<EstudianteMateriaModel> estudiantes = [];
    try {
      debugPrint("json: $json");
      debugPrint("json materia curso: $json");
      estudiantes = json['materia_estudiante'] ??
          (json['materia_estudiante'] as List)
              .map((e) => EstudianteMateriaModel.fromMap(e))
              .toList()
              .cast<EstudianteMateriaModel>();
      debugPrint("estudiantes: $estudiantes");
    } catch (e) {
      debugPrint("No existe '[materia_estudiante]': $e");
    }
    return MateriaEstudianteModel(
        id: json['id'],
        estudiante: EstudianteModel.fromMap(json['estudiante']),
        materiaEstudiantes: estudiantes);
  }

  factory MateriaEstudianteModel.fromMapTrimestres(Map<String, dynamic> json) {
    return MateriaEstudianteModel(
        id: json['id'],
        estudiante: EstudianteModel.fromMap(json['estudiante']),
        trimestres: (json['estudiante_trimestre'] as List)
            .map((e) => CabeceraTrimestreModel.fromMap(e))
            .toList());
  }

  @override
  String toString() {
    return "{id: $id, estudiante: $estudiante, materiaEstudiantes: $materiaEstudiantes, materiaCursoDocente: $materiaCursoDocente }";
  }
}
