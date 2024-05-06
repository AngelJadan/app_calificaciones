import 'dart:convert';

import 'package:app_calificaciones/models/abstract_model.dart';
import 'package:app_calificaciones/models/trimestre_cabecera_model.dart';

class DetalleTrimestreModel extends AbstractModel<int> {
  DetalleTrimestreModel({
    id,
    this.tipoAporte,
    this.cabeceraTrimestre,
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

  int? tipoAporte;
  CabeceraTrimestreModel? cabeceraTrimestre;

  @override
  Map<String, dynamic> toJson() {
    Iterable<Map> aporte =
        aportes.where((element) => element['id'] == tipoAporte);
    if (aporte.isEmpty) {
      throw Exception({
        "tipoAporte": "No existe el aporte ingresado",
      });
    }
    return {
      "id": id,
      "tipo_aporte": tipoAporte,
      "cabecera_trimestre": cabeceraTrimestre!.id,
    };
  }

  factory DetalleTrimestreModel.fromMap(Map<String, dynamic> json) =>
      DetalleTrimestreModel(
        id: json['id'],
        tipoAporte: json['tipo_aporte'],
        cabeceraTrimestre: CabeceraTrimestreModel.fromMap(
          json['cabecera_trimestre'],
        ),
      );

  factory DetalleTrimestreModel.fromJson(String str) =>
      DetalleTrimestreModel.fromMap(json.decode(str));

  @override
  String toString() {
    return "{id: $id, tipoAporte: $tipoAporte, cabeceraTrimestre: $cabeceraTrimestre}";
  }
}
