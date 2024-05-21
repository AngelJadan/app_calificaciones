import 'package:app_calificaciones/models/abstract_model.dart';
import 'package:app_calificaciones/models/calificacion_estudiante/trimestre_cabecera_model.dart';
import 'package:app_calificaciones/models/estudiante_model.dart';
import 'package:flutter/material.dart';

class EstudianteMateriaModel extends AbstractModel<int> {
  EstudianteMateriaModel({
    id,
    this.estudiante,
    this.cabeceraTrimestre,
  }) : super(id);

  EstudianteModel? estudiante;
  List<CabeceraTrimestreModel>? cabeceraTrimestre;

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }

  CabeceraTrimestreModel getFirstTrimestre() {
    return cabeceraTrimestre!
        .where((element) => element.numeroTrimestre == 1)
        .first;
  }

  factory EstudianteMateriaModel.fromMap(Map<String, dynamic> json) {
    debugPrint("json['cabecera_trimestre'], $json");
    return EstudianteMateriaModel(
      id: json['id'],
      cabeceraTrimestre: (json['cabecera_trimestre'] as List)
          .map((e) => CabeceraTrimestreModel.fromMap(e))
          .toList()
          .cast<CabeceraTrimestreModel>(),
    );
  }
}
