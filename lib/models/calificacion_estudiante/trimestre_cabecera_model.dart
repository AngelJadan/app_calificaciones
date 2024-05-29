import 'dart:convert';

import 'package:app_calificaciones/models/abstract_model.dart';
import 'package:app_calificaciones/models/calificacion_estudiante/trimestre_detalle_calificacion.dart';
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
    this.detalleCalificacion,
    this.usuario,
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
  List<TrimestreDetalleCalificacion>? detalleCalificacion;
  int? usuario;

  updateCalificacion(TrimestreDetalleCalificacion oldDetalleCalificacion,
      TrimestreDetalleCalificacion newDetalleCalificacion) {
    detalleCalificacion?.remove(oldDetalleCalificacion);
    detalleCalificacion?.add(newDetalleCalificacion);
  }

  addDetalleCalificacion(TrimestreDetalleCalificacion newDetalleCalificacion) {
    detalleCalificacion?.add(newDetalleCalificacion);
  }

  validarNumeroTrimestre() {
    numeroTrimestre == null
        ? throw Exception({"numeroTrimestre": "No puede ser nulo"})
        : null;
    numeroTrimestre! > 2
        ? throw Exception(
            {"numeroTrimestre": "No puede existir mas de 2 trimestres"})
        : null;
    materiaEstudiante == null
        ? throw Exception({"materiaEstudiante": "No puede ser un valor nulo"})
        : null;
    usuario == null
        ? throw Exception({"usuario": "No puede ser un valor nulo"})
        : null;
  }

  @override
  Map<String, dynamic> toJson() {
    validarNumeroTrimestre();
    return {
      "id": id,
      "numero_trimestre": numeroTrimestre,
      "materia_estudiante": materiaEstudiante!.id,
      "aporte_cualitativo": aporteCualitativo,
      "proyecto_integrador": proyectoIntegrador,
      "cualitativo_proyecto_integrador": cualitativoProyectoIntegrador,
      "calificacion_detalle": detalleCalificacion!
          .map(
            (e) => e.toJson(),
          )
          .toList(),
      "usuario": usuario,
    };
  }

  ///
  ///@param int aporte 1 (INDIVIDUAL) o 2 (GRUPAL)
  ///@param int actividad 1(LECCION),2 (PRUEBAS), 3 (TAREAS), 4 (PROYECTOS), 5 (EXPOSICIONES), 6 (TALLER)
  ///@param int item 1, 2, 3, 4
  ///@return DetalleTrimestreModel?
  TrimestreDetalleCalificacion getCalificacion(
      int aporte, int actividad, int item) {
    var calificacion = detalleCalificacion!.where((element) =>
        element.actividad == actividad &&
        element.aporte == aporte &&
        element.item == item);
    var data = calificacion.isNotEmpty
        ? calificacion.first
        : TrimestreDetalleCalificacion(calificacion: 0);
    return data;
  }

  factory CabeceraTrimestreModel.fromJson(String str) =>
      CabeceraTrimestreModel.fromMap(json.decode(str));

  factory CabeceraTrimestreModel.fromMap(Map<String, dynamic> json) =>
      CabeceraTrimestreModel(
        id: json['id'],
        numeroTrimestre: json['numero_trimestre'],
        aporteCualitativo: int.parse(json['aporte_cualitativo']),
        proyectoIntegrador: json['proyecto_integrador'],
        materiaEstudiante:
            MateriaEstudianteModel(id: json['materia_estudiante']),
        cualitativoProyectoIntegrador:
            int.parse(json['cualitativo_proyecto_integrador']),
        detalleCalificacion: (json['calificacion_detalle'] as List)
            .map((e) => TrimestreDetalleCalificacion.fromMap(e))
            .toList(),
      );

  @override
  String toString() {
    return "{id: $id, numeroTrimestre: $numeroTrimestre, aporteCualitativo: $aporteCualitativo, proyectoIntegrador: $proyectoIntegrador, cualitativoProyectoIntegrador: $cualitativoProyectoIntegrador, materiaEstudiante: $materiaEstudiante, detalleTrimestre: $detalleCalificacion, usuario: $usuario }";
  }
}
