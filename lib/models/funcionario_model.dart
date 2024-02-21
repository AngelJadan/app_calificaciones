import 'package:app_calificaciones/models/login_model.dart';

class FuncionarioModel extends LoginModel {
  FuncionarioModel(
      {id,
      nombre,
      apellido,
      correo,
      identificacion,
      nombreUsuario,
      password,
      tipoIdentificacion,
      this.fechaIngreso,
      this.fechaSalida,
      this.tipo});

  String? fechaIngreso;
  String? fechaSalida;
  String? tipo;
}
