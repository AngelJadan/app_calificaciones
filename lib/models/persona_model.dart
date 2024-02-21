import 'dart:convert';
import 'dart:math';

import 'package:app_calificaciones/models/abstract_model.dart';

class PersonaModel extends AbstractModel<int> {
  PersonaModel({
    id,
    this.nombre,
    this.apellido,
    this.nombreUsuario,
    this.correo,
    this.identificacion,
    this.fechaIngreso,
    this.fechaSalida,
    this.tipo,
  }) : super(id);

  String? nombre;
  String? apellido;
  String? nombreUsuario;
  String? correo;
  String? identificacion;
  String? tipoIdetificacion;
  DateTime? fechaIngreso;
  DateTime? fechaSalida;
  String? tipo;

  String getTipo(String key) {
    String data = "";
    switch (key) {
      case "1":
        data = "Docente";
        break;
      case "2":
        data = "Rector";
        break;
      case "3":
        data = "Secretaria";
        break;
      default:
    }
    return data;
  }

  bool isdigit(String texto) {
    try {
      double.parse(texto);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool validarCedula(String cedula) {
    // Verificar que la cédula tenga 10 dígitos
    if (cedula.length != 10) {
      return false;
    }

    // Extraer el décimo dígito (dígito verificador)
    int verificador = int.parse(cedula[9]);

    // Calcular la suma de verificación
    int suma = 0;
    for (int i = 0; i < 9; i++) {
      int digito = int.parse(cedula[i]);
      if (i % 2 == 0) {
        digito *= 2;
        if (digito > 9) {
          digito -= 9;
        }
      }
      suma += digito;
    }

    // Calcular el dígito verificador esperado
    int digitoEsperado = 10 - (suma % 10);
    if (digitoEsperado == 10) {
      digitoEsperado = 0;
    }

    // Comparar el dígito verificador esperado con el proporcionado
    return digitoEsperado == verificador;
  }

  String getTipoDocumento(String tipo) {
    String tDocument = "";
    if (tipo == "1") {
      tDocument = "Cedula";
    }
    if (tipo == "2") {
      tDocument = "Pasaporte";
    }
    return tDocument;
  }

  String textToNumberTipoDocumento() {
    return tipoIdetificacion == "Cedula" ? "1" : "2";
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": nombre,
        "last_name": apellido,
        "username": nombreUsuario,
        "email": correo,
        "identificacion": identificacion,
        "tipo_identificacion": textToNumberTipoDocumento(),
        "fecha_ingreso":
            "${fechaIngreso!.year}-${fechaIngreso!.month}-${fechaIngreso!.day}",
        "fecha_salida": fechaSalida != null
            ? "${fechaSalida!.year}-${fechaSalida!.month}-${fechaSalida!.day}"
            : null,
        "tipo": tipo,
      };

  factory PersonaModel.fromJson(String str) =>
      PersonaModel.fromMap(json.decode(str));

  factory PersonaModel.fromMap(Map<String, dynamic> json) => PersonaModel(
        id: json["id"],
        nombre: json["first_name"],
        apellido: json["last_name"],
        nombreUsuario: json["username"],
        correo: json["email"],
        identificacion: json["identificacion"],
        fechaIngreso: DateTime.parse(json["fecha_ingreso"]),
        fechaSalida: json["fecha_salida"] != null
            ? DateTime.parse(json["fecha_salida"])
            : null,
        tipo: json["tipo"],
      );

  @override
  String toString() {
    return "{id: $id, nombre: $nombre, apellido: $apellido, nombreUsuario: $nombreUsuario, correo: $correo, identificacion: $identificacion, fechaIngreso: $fechaIngreso, fechaSalida: $fechaSalida, tipo: $tipo}";
  }
}
