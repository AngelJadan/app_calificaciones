import 'dart:convert';

import 'package:app_calificaciones/models/abstract_model.dart';
import 'package:app_calificaciones/models/detalle_trimestre_model.dart';

class CabeceraActividadModel extends AbstractModel<int> {
  CabeceraActividadModel({
    id,
    this.nombre,
    this.detalleTrimestre,
    this.usuario,
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
  DetalleTrimestreModel? detalleTrimestre;
  int? usuario;

  void validarActividad() {
    if (listNombre.where((element) => element['id'] == nombre).isEmpty) {
      throw Exception({"nombre": "El nombre de la actividad no existe"});
    }
  }

  @override
  Map<String, dynamic> toJson() {
    validarActividad();
    return {
      "id": id,
      "nombre": nombre,
      "detalle_trimestre": detalleTrimestre!.id,
      "usuario": usuario,
    };
  }

  factory CabeceraActividadModel.fromJson(String str) =>
      CabeceraActividadModel.fromMap(json.decode(str));

  factory CabeceraActividadModel.fromMap(Map<String, dynamic> json) =>
      CabeceraActividadModel(
        id: json["id"],
        nombre: json["nombre"],
        detalleTrimestre: DetalleTrimestreModel.fromMap(
          json['detalle_trimestre'],
        ),
        usuario: json['usuario'],
      );

  @override
  String toString() {
    return "{id: $id, nombre: $nombre, detalleTrimestre: $detalleTrimestre, usuario: $usuario }";
  }
}
