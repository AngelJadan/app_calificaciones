import 'dart:convert';

import 'package:app_calificaciones/models/abstract_model.dart';

class LoginModel extends AbstractModel {
  LoginModel({
    id,
    this.nombre,
    this.apellido,
    this.tipoIdentificacion,
    this.identificacion,
    this.correo,
    this.password,
    this.tipoUsuario,
    this.token,
    this.cookies,
  }) : super(id);

  String? nombre;
  String? apellido;
  String? nombreUsuario;
  String? tipoIdentificacion;
  String? identificacion;
  String? correo;
  String? password;
  String? tipoUsuario = "1";
  String? token;
  String? cookies;

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": nombre,
        "last_name": apellido,
        "type_identification": tipoIdentificacion,
        "identification": identificacion,
        "email": correo,
        "type_user": tipoUsuario,
        "token": token,
        "cookies": cookies,
      };

  factory LoginModel.fromJson(String str) =>
      LoginModel.fromMap(json.decode(str));

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
        id: json['id'],
        nombre: json['first_name'],
        apellido: json['last_name'],
        tipoIdentificacion: json['type_identification'],
        identificacion: json['identification'],
        correo: json['email'],
        tipoUsuario: json['type_user'],
        token: json["token"],
        cookies: json['cookies'] ?? "",
      );

  @override
  String toString() {
    return "correo: $correo, $password";
  }
}
