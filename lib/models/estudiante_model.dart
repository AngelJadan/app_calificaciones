import 'dart:convert';

import 'package:app_calificaciones/models/persona_model.dart';

class EstudianteModel extends PersonaModel {
  EstudianteModel({
    super.id,
    super.nombre,
    super.apellido,
    super.correo,
    super.identificacion,
    super.nombreUsuario,
    super.tipoIdetificacion,
    this.fechaNacimiento,
  });

  DateTime? fechaNacimiento;

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": nombre,
        "last_name": apellido,
        "email": correo,
        "identificacion": identificacion,
        "username": nombreUsuario,
        "tipo_identificacion": tipoIdetificacion,
        "fecha_nacimiento":
            "${fechaNacimiento!.year}-${fechaNacimiento!.month}-${fechaNacimiento!.day}",
      };

  factory EstudianteModel.fromJson(String str) =>
      EstudianteModel.fromMap(json.decode(str));

  factory EstudianteModel.fromMap(Map<String, dynamic> json) => EstudianteModel(
        id: json['id'],
        nombre: json['first_name'],
        apellido: json['last_name'],
        correo: json['email'],
        identificacion: json['identificacion'],
        nombreUsuario: json['username'],
        tipoIdetificacion: json['tipo_identificacion'],
        fechaNacimiento: DateTime.parse(json['fecha_nacimiento']),
      );

  @override
  String toString() {
    return "{id: $id, nombre: $nombre, apellido: $apellido, correo: $correo, identificacion: $identificacion, nombreUsuario: $nombreUsuario, tipoIdentificacion: $tipoIdetificacion, fechaNacimiento: $fechaNacimiento }";
  }
}
