import 'package:app_calificaciones/models/abstract_model.dart';

class CursoModel extends AbstractModel<int> {
  CursoModel({
    id,
    this.nombre,
    this.nivel,
    this.paralelo,
  }) : super(id);

  String? nombre;
  String? nivel;
  Map? paralelo;

  @override
  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "nivel": nivel,
        "paralelo": paralelo!['id'],
      };

  factory CursoModel.fromMap(Map<String, dynamic> json) => CursoModel(
        id: json['id'],
        nombre: json['nombre'],
        nivel: json['nivel'],
        paralelo: json['paralelo'],
      );

  @override
  String toString() {
    return "{id: $id, nombre: $nombre, nivel: $nivel, paralelo: $paralelo }";
  }
}
