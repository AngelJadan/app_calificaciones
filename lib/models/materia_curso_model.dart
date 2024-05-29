import 'package:app_calificaciones/models/abstract_model.dart';
import 'package:app_calificaciones/models/calificacion_estudiante/estudiante_materia_models.dart';
import 'package:app_calificaciones/models/calificacion_estudiante/trimestre_cabecera_model.dart';
import 'package:app_calificaciones/models/estudiante_model.dart';
import 'package:app_calificaciones/models/materia_curso_docente_model.dart';
import 'package:flutter/material.dart';

class MateriaEstudianteModel extends AbstractModel<int> {
  MateriaEstudianteModel({
    id,
    this.estudiante,
    this.materiaCursoDocente,
    this.materiaEstudiantes,
    this.trimestres,
    this.usuario,
  }) : super(id);

  EstudianteModel? estudiante;
  MateriaCursoDocente? materiaCursoDocente;
  List<EstudianteMateriaModel>? materiaEstudiantes;
  List<CabeceraTrimestreModel>? trimestres;
  int? usuario;

  CabeceraTrimestreModel getPrimerTrimestre() {
    // debugPrint("Obteniendo TRimestre: $trimestres");
    var data = trimestres != null && trimestres!.isNotEmpty
        ? trimestres!
                .where((element) => element.numeroTrimestre == 1)
                .isNotEmpty
            ? trimestres!.where((element) => element.numeroTrimestre == 1).first
            : CabeceraTrimestreModel(detalleCalificacion: [])
        : CabeceraTrimestreModel(detalleCalificacion: []);
    return data;
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
        "usuario": usuario,
      };

  factory MateriaEstudianteModel.fromMap(Map<String, dynamic> json) {
    //debugPrint("json: $json");

    List<EstudianteMateriaModel> estudiantes = [];
    try {
      estudiantes = json['materia_estudiante'] ??
          (json['materia_estudiante'] as List)
              .map((e) => EstudianteMateriaModel.fromMap(e))
              .toList()
              .cast<EstudianteMateriaModel>();
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
    return "{id: $id, estudiante: $estudiante, materiaEstudiantes: $materiaEstudiantes, materiaCursoDocente: $materiaCursoDocente, trimestres: $trimestres }";
  }
}
