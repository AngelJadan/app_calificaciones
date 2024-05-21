import 'dart:convert';

import 'package:app_calificaciones/models/abstract_model.dart';
import 'package:app_calificaciones/models/calificacion_estudiante/cabecera_actividad_model.dart';
import 'package:app_calificaciones/models/calificacion_estudiante/trimestre_cabecera_model.dart';
import 'package:flutter/material.dart';

class DetalleTrimestreModel extends AbstractModel<int> {
  DetalleTrimestreModel({
    id,
    this.nombre,
    this.cabeceraTrimestre,
    this.cabecerasActividad,
  }) : super(id);

  List<Map> aportes = [
    {
      "id": 1,
      "descripcion":
          "Actividades Disciplinares o interdisciplinares individuales.",
    },
    {
      "id": 2,
      "descripcion": "Actividades Disciplinares o interdisciplinares grupales.",
    },
  ];

  int? nombre;
  CabeceraTrimestreModel? cabeceraTrimestre;

  List<CabeceraActividadModel>? cabecerasActividad;

  CabeceraActividadModel getLecciones() {
    debugPrint("cabecerasActividad $cabecerasActividad");
    var data = cabecerasActividad != null
        ? nombre == 1
            ? cabecerasActividad!
                    .where((element) => element.nombre == 1)
                    .isEmpty
                ? cabecerasActividad!
                    .where((element) => element.nombre == 1)
                    .first
                : CabeceraActividadModel(detalleActividad: [])
            : throw Exception(
                "Las lecciones solo se pueden obtener desde los aportes inividuales.")
        : CabeceraActividadModel(detalleActividad: []);
    debugPrint("data: $data");
    return data;
  }

  CabeceraActividadModel getPruebas() {
    return nombre == 1
        ? cabecerasActividad!.where((element) => element.nombre == 2).isEmpty
            ? cabecerasActividad!.where((element) => element.nombre == 2).first
            : CabeceraActividadModel(calificacion: 0)
        : throw Exception(
            "Las pruebas solo se pueden obtener desde los aportes inividuales.");
  }

  CabeceraActividadModel getTareas() {
    return nombre == 1
        ? cabecerasActividad!.where((element) => element.nombre == 3).isNotEmpty
            ? cabecerasActividad!.where((element) => element.nombre == 3).first
            : CabeceraActividadModel(calificacion: 0)
        : throw Exception(
            "Las tareas solo se pueden obtener desde los aportes inividuales.");
  }

  CabeceraActividadModel getProyectos() {
    return nombre == 2
        ? cabecerasActividad!.where((element) => element.nombre == 1).isNotEmpty
            ? cabecerasActividad!.where((element) => element.nombre == 1).first
            : CabeceraActividadModel(calificacion: 0)
        : throw Exception(
            "Las pruebas solo se pueden obtener desde los aportes grupales.");
  }

  CabeceraActividadModel getExposiciones() {
    return nombre == 2
        ? cabecerasActividad!.where((element) => element.nombre == 2).first
        : throw Exception(
            "Las pruebas solo se pueden obtener desde los aportes grupales.");
  }

  CabeceraActividadModel getTalleres() {
    return nombre == 2
        ? cabecerasActividad!.where((element) => element.nombre == 3).first
        : throw Exception(
            "Las tareas solo se pueden obtener desde los aportes inividuales.");
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nombre": nombre,
      "cabecera_actividad": cabecerasActividad!
          .map(
            (e) => e.toJson(),
          )
          .toList(),
    };
  }

  factory DetalleTrimestreModel.fromMap(Map<String, dynamic> json) {
    debugPrint("json DetalleTrimestreModel: $json");
    return DetalleTrimestreModel(
      id: json['id'],
      nombre: int.parse(json['tipo_aporte']),
      cabecerasActividad: (json['cabecera_actividad'] as List)
          .map((e) => CabeceraActividadModel.fromMap(e))
          .toList(),
    );
  }

  factory DetalleTrimestreModel.fromJson(String str) =>
      DetalleTrimestreModel.fromMap(json.decode(str));

  @override
  String toString() {
    return "{id: $id, nombre: $nombre, cabeceraTrimestre: $cabeceraTrimestre}";
  }
}
