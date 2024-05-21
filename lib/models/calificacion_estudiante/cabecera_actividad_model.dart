import 'dart:convert';

import 'package:app_calificaciones/models/abstract_model.dart';
import 'package:app_calificaciones/models/calificacion_estudiante/detalle_actividad_model.dart';
import 'package:app_calificaciones/models/calificacion_estudiante/detalle_trimestre_model.dart';
import 'package:flutter/material.dart';

class CabeceraActividadModel extends AbstractModel<int> {
  CabeceraActividadModel({
    id,
    this.nombre,
    this.calificacion,
    this.detalleTrimestre,
    this.usuario,
    this.detalleActividad,
  }) : super(id);

  List<Map> listNombre = [
    {
      "id": 1,
      "descripcion": "LECCIONES ORALES/ESCRITAS",
    },
    {
      "id": 2,
      "descripcion": "PRUEBAS BASE ESTRUCTURADA",
    },
    {
      "id": 3,
      "descripcion": "TAREAS/EJERCICIOS",
    },
    {
      "id": 4,
      "descripcion": "PROYECTOS INTEGRADORES",
    },
    {
      "id": 5,
      "descripcion": "EXPOSICIONES/FOROS",
    },
    {
      "id": 6,
      "descripcion": "TALLERES",
    },
  ];

  int? nombre;
  int? usuario;
  double? calificacion;
  DetalleTrimestreModel? detalleTrimestre;
  List<DetalleActividadModel>? detalleActividad;

  DetalleActividadModel getLeccion(int numeroLeccion) {
    debugPrint("Obteniendo leccion");
    debugPrint("DetalleActividad: $detalleActividad");
    debugPrint("nombre: $nombre");
    return detalleActividad!.isNotEmpty
        ? nombre == 1
            ? detalleActividad!
                    .where((element) => element.nombre == numeroLeccion)
                    .isNotEmpty
                ? detalleActividad!
                    .where((element) => element.nombre == numeroLeccion)
                    .first
                : DetalleActividadModel(calificacion: 0)
            : throw Exception(
                "Para acceder a la leccion escrita debe acceder desde lecciones")
        : DetalleActividadModel(calificacion: 0);
  }

  DetalleActividadModel getPrueba(int numeroPrueba) {
    var data =
        detalleActividad!.where((element) => element.nombre == numeroPrueba);
    return detalleActividad != null
        ? nombre == 2
            ? data.isEmpty
                ? DetalleActividadModel(calificacion: 0)
                : data.first
            : throw Exception(
                "Para acceder a la leccion escrita debe acceder desde lecciones")
        : DetalleActividadModel(calificacion: 0);
  }

  /// @param numeroLeccion: 1, 2, 3, 4.
  /// @return DetalleActividadModel
  DetalleActividadModel getTarea(int numeroLeccion) {
    var data =
        detalleActividad!.where((element) => element.nombre == numeroLeccion);
    return detalleActividad != null
        ? nombre == 3
            ? data.isEmpty
                ? DetalleActividadModel(calificacion: 0)
                : data.first
            : throw Exception(
                "Para acceder a la tarea escrita debe acceder desde tareas")
        : DetalleActividadModel(calificacion: 0);
  }

  DetalleActividadModel getProyecto1(int numeroProyecto) {
    var data =
        detalleActividad!.where((element) => element.nombre == numeroProyecto);
    return detalleActividad != null
        ? nombre == 1
            ? data.isEmpty
                ? DetalleActividadModel(calificacion: 0)
                : data.first
            : throw Exception(
                "Para acceder al proyecto debe acceder desde proyectos")
        : DetalleActividadModel(calificacion: 0);
  }

  DetalleActividadModel getExposicion1() {
    return nombre == 5
        ? detalleActividad!.where((element) => element.nombre == 1).first
        : throw Exception(
            "Para acceder a exposicion1 debe acceder desde talleres");
  }

  DetalleActividadModel getExposicion2() {
    return nombre == 5
        ? detalleActividad!.where((element) => element.nombre == 2).first
        : throw Exception(
            "Para acceder a exposicion2 debe acceder desde talleres");
  }

  DetalleActividadModel getExposicion3() {
    return nombre == 5
        ? detalleActividad!.where((element) => element.nombre == 3).first
        : throw Exception(
            "Para acceder a exposicion3 debe acceder desde talleres");
  }

  DetalleActividadModel getExposicion4() {
    return nombre == 5
        ? detalleActividad!.where((element) => element.nombre == 4).first
        : throw Exception(
            "Para acceder a exposicion4 debe acceder desde talleres");
  }

  DetalleActividadModel getTaller1() {
    return nombre == 6
        ? detalleActividad!.where((element) => element.nombre == 1).first
        : throw Exception("Para acceder a taller1 debe acceder desde talleres");
  }

  DetalleActividadModel getTaller2() {
    return nombre == 6
        ? detalleActividad!.where((element) => element.nombre == 2).first
        : throw Exception("Para acceder a taller2 debe acceder desde talleres");
  }

  DetalleActividadModel getTaller3() {
    return nombre == 6
        ? detalleActividad!.where((element) => element.nombre == 3).first
        : throw Exception("Para acceder a taller3 debe acceder desde talleres");
  }

  DetalleActividadModel getTaller4() {
    return nombre == 6
        ? detalleActividad!.where((element) => element.nombre == 4).first
        : throw Exception("Para acceder a taller4 debe acceder desde talleres");
  }

  void validarCantidadDetalleActividad() {
    if (detalleActividad == null) {
      throw Exception({"detalleActividad": "La lista no puede ser nula"});
    }
    if (detalleActividad!.length > 3) {
      throw Exception(
          {"detalleActividad": "No se puede tener mas de 3 actividades"});
    }
  }

  void validarActividad() {
    if (detalleTrimestre == null) {
      throw Exception({"detalleTrimestre": "Valor nulo"});
    }
    if (listNombre.where((element) => element['id'] == nombre).isEmpty) {
      throw Exception({"nombre": "El nombre de la actividad no existe"});
    }
  }

  @override
  Map<String, dynamic> toJson() {
    validarActividad();
    validarCantidadDetalleActividad();
    return {
      "id": id,
      "nombre": nombre,
      "detalle_actividad": detalleActividad!.map((e) => e.toJson()).toList(),
      "usuario": usuario,
    };
  }

  factory CabeceraActividadModel.fromJson(String str) =>
      CabeceraActividadModel.fromMap(json.decode(str));

  factory CabeceraActividadModel.fromMap(Map<String, dynamic> json) {
    debugPrint("cabeceraActividad: $json");
    return CabeceraActividadModel(
        id: json["id"],
        nombre: int.parse(json["nombre"]),
        calificacion: json['calificacion'],
        detalleActividad: (json['detalle_actividad'] as List)
            .map((e) => DetalleActividadModel.fromMap(e))
            .toList());
  }

  @override
  String toString() {
    return "{id: $id, nombre: $nombre, calificacion: $calificacion, detalleTrimestre: $detalleTrimestre, usuario: $usuario }";
  }
}
