import 'package:app_calificaciones/models/login_model.dart';

class Estudiante extends LoginModel {
  Estudiante({
    id,
    nombre,
    apellido,
    correo,
    identificacion,
    nombreUsuario,
    password,
    tipoIdentificacion,
    this.fechaNacimiento,
  });

  String? fechaNacimiento;
}
