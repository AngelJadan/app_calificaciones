import 'dart:convert';

import 'package:app_calificaciones/models/abstract_model.dart';
import 'package:app_calificaciones/models/calificacion_estudiante/detalle_actividad_model.dart';
import 'package:app_calificaciones/models/calificacion_estudiante/detalle_trimestre_model.dart';
import 'package:app_calificaciones/models/materia_curso_model.dart';
import 'package:flutter/material.dart';

class CabeceraTrimestreModel extends AbstractModel<int> {
  CabeceraTrimestreModel({
    id,
    this.numeroTrimestre,
    this.materiaEstudiante,
    this.aporteCualitativo,
    this.proyectoIntegrador,
    this.cualitativoProyectoIntegrador,
    this.detalleTrimestre,
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
  int? proyectoIntegrador;
  int? cualitativoProyectoIntegrador;
  List<DetalleTrimestreModel>? detalleTrimestre;

  validarNumeroTrimestre() {
    numeroTrimestre == null
        ? throw Exception({"numeroTrimestre": "No puede ser nulo"})
        : null;
    numeroTrimestre! > 2
        ? throw Exception(
            {"numeroTrimestre": "No puede existir mas de 2 trimestres"})
        : null;
  }

  /*
  validarActividades() {
    if (actividades == null) {
      throw Exception({"actividades": "No puede ser nulo"});
    }
    if (actividades!.length > 2) {
      throw Exception(
          {"actividades": "No pueden existir mas de 2 actividades"});
    }
  }*/

  DetalleActividadModel getActividad(
      List<DetalleActividadModel> actividades, int actividad) {
    return actividades.where((element) => element.nombre == actividad).first;
  }

  @override
  Map<String, dynamic> toJson() {
    validarNumeroTrimestre();
    return {
      "id": id,
      "numero_trimestre": numeroTrimestre,
      "materia_estudiante": materiaEstudiante!.id,
      "aporte_cualitativo": (calificacion
          .where((element) => element['id'] == aporteCualitativo)
          .first)['id'],
      "proyecto_integrador": (calificacion
          .where((element) => element['id'] == proyectoIntegrador)
          .first)['id'],
      "cualitativo_proyecto_integrador": (calificacion
          .where((element) => element['id'] == cualitativoProyectoIntegrador)
          .first)['id'],
      "detalle_trimestre": detalleTrimestre!.map((e) => e.toJson()).toList(),
    };
  }

  DetalleTrimestreModel getAporteIndividual() {
    debugPrint("obteniendo APORTE INDIVIDUAL");
    debugPrint("detalleTrimestre: $detalleTrimestre");
    var data = detalleTrimestre!.isNotEmpty
        ? detalleTrimestre!.where((element) => element.nombre == 1).isNotEmpty
            ? detalleTrimestre!.where((element) => element.nombre == 1).first
            : DetalleTrimestreModel(cabecerasActividad: [])
        : DetalleTrimestreModel(cabecerasActividad: []);
    debugPrint("data: $data");
    return data;
  }

  DetalleTrimestreModel getAporteGrupal() {
    debugPrint("obteniendo APORTE GRUPAL");
    debugPrint("detalleTrimestre: $detalleTrimestre");
    return detalleTrimestre != null
        ? detalleTrimestre!.where((element) => element.nombre == 2).isNotEmpty
            ? detalleTrimestre!.where((element) => element.nombre == 2).first
            : DetalleTrimestreModel()
        : DetalleTrimestreModel();
  }

  Map getCalificacion(int id) =>
      calificacion.where((element) => element['id'] == id).first;

  factory CabeceraTrimestreModel.fromJson(String str) =>
      CabeceraTrimestreModel.fromMap(json.decode(str));

  factory CabeceraTrimestreModel.fromMap(Map<String, dynamic> json) {
    debugPrint("jsonTrimestre: $json");
    debugPrint("jsonDetalleTrimestre: ${json['detalle_trimestre']}");
    return CabeceraTrimestreModel(
      id: json['id'],
      numeroTrimestre: json['numero_trimestre'],
      aporteCualitativo: int.parse(json['aporte_cualitativo']),
      proyectoIntegrador: json['proyecto_integrador'],
      cualitativoProyectoIntegrador:
          int.parse(json['cualitativo_proyecto_integrador']),
      detalleTrimestre: (json['detalle_trimestre'] as List)
          .map((e) => DetalleTrimestreModel.fromMap(e))
          .toList(),
    );
  }

  @override
  String toString() {
    return "{id: $id, numeroTrimestre: $numeroTrimestre, materiaEstudiante: $materiaEstudiante, aporteCualitativo: $aporteCualitativo, cualitativoProyectoIntegrador: $cualitativoProyectoIntegrador, detalleTrimestre: $detalleTrimestre }";
  }
}
