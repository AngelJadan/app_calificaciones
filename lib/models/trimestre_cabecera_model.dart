import 'dart:convert';

import 'package:app_calificaciones/models/abstract_model.dart';
import 'package:app_calificaciones/models/materia_curso_model.dart';

class CabeceraTrimestreModel extends AbstractModel<int> {
  CabeceraTrimestreModel({
    id,
    this.numeroTrimestre,
    this.materiaEstudiante,
    this.aporteCualitativo,
    this.cualitativoProyectoIntegrador,
  }) : super(id);

  List<Map> calificacion = [
    {
      "id": 0,
      "descripcion": "(NE) No evaluado.",
    },
    {
      "id": 1,
      "descripcion": "(I) Destreza o aprendizaje iniciado.",
    },
    {
      "id": 2,
      "descripcion": "(EP) Destreza o aprendizaje en proceso de desarrollo.",
    },
    {
      "id": 3,
      "descripcion": "(A) Destreza o aprendizaje alcanzado.",
    },
  ];

  int? numeroTrimestre;
  MateriaEstudianteModel? materiaEstudiante;
  int? aporteCualitativo;
  int? cualitativoProyectoIntegrador;

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "numero_trimestre": numeroTrimestre,
        "materia_estudiante": materiaEstudiante!.id,
        "aporte_cualitativo": (calificacion
            .where((element) => element['id'] == aporteCualitativo)
            .first)['id'],
        "proyecto_integrador": cualitativoProyectoIntegrador,
        "cualitativo_proyecto_integrador": (calificacion
            .where((element) => element['id'] == cualitativoProyectoIntegrador)
            .first)['id'],
      };

  Map getCalificacion(int id) =>
      calificacion.where((element) => element['id'] == id).first;

  factory CabeceraTrimestreModel.fromJson(String str) =>
      CabeceraTrimestreModel.fromMap(json.decode(str));

  factory CabeceraTrimestreModel.fromMap(Map<String, dynamic> json) =>
      CabeceraTrimestreModel(
        id: json['id'],
        numeroTrimestre: json['numero_trimestre'],
        materiaEstudiante: json['materia_estudiante'],
        aporteCualitativo: json['aporte_cualitativo'],
        cualitativoProyectoIntegrador: json['cualitativo_proyecto_integrador'],
      );

  @override
  String toString() {
    return "{id: $id, numeroTrimestre: $numeroTrimestre, materiaEstudiante: $materiaEstudiante, aporteCualitativo: $aporteCualitativo, cualitativoProyectoIntegrador: $cualitativoProyectoIntegrador }";
  }
}
