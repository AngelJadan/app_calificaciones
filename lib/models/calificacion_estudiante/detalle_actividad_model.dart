import 'dart:convert';

import 'package:app_calificaciones/models/abstract_model.dart';
import 'package:app_calificaciones/models/calificacion_estudiante/cabecera_actividad_model.dart';
import 'package:flutter/material.dart';

class DetalleActividadModel extends AbstractModel<int> {
  DetalleActividadModel({
    id,
    this.nombre,
    this.calificacion,
    this.cabeceraActividadModel,
  }) : super(id);

  int? nombre;
  int? calificacion;
  CabeceraActividadModel? cabeceraActividadModel;

  List<Map> nombres = [
    {
      "id": 1,
      "descripcion": "LECCION ESCRITA DE LAS PARTES ORACION",
    },
    {
      "id": 2,
      "descripcion": "LECCION ESCRITA DE LAS PARTES ORACION",
    },
    {
      "id": 3,
      "descripcion": "",
    },
    {
      "id": 4,
      "descripcion": "CUALITATIVO",
    },
  ];

  void validarCalificacion() {
    if (calificacion! < 0) {
      throw Exception(
        {"calificacion": "La calificación no puede ser menor a 0"},
      );
    }
    if (calificacion! > 3) {
      throw Exception(
        {"calificacion": "La calificación no puede ser mayor a 3"},
      );
    }
  }

  void validarNombre() {
    if (nombres.where((element) => element['id'] == nombre).isEmpty) {
      throw Exception(
          {"nombre": "Valor invalido 'nombre' no existe en la lista $nombres"});
    }
  }

  @override
  Map<String, dynamic> toJson() {
    validarCalificacion();
    validarNombre();
    return {
      "id": id,
      "nombre": nombre,
      "calificacion": calificacion,
      "cabecera_actividad": cabeceraActividadModel!.id,
    };
  }

  factory DetalleActividadModel.fromJson(String str) =>
      DetalleActividadModel.fromMap(json.decode(str));

  factory DetalleActividadModel.fromMap(Map<String, dynamic> json) {
    debugPrint("detalleActividadModel: $json");
    return DetalleActividadModel(
      id: json['id'],
      nombre: int.parse(json['nombre']),
      calificacion: json['calificacion'],
    );
  }

  @override
  String toString() {
    return "{id: $id, nombre: $nombre, calificacion: $calificacion, cabeceraActividadModel: $cabeceraActividadModel}";
  }
}
