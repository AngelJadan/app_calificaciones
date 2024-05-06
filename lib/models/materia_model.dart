import 'package:app_calificaciones/models/abstract_model.dart';

class MateriaModel extends AbstractModel<int> {
  MateriaModel({id, this.nombre, this.area}) : super(id);

  Map? area;
  String? nombre;

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "area": area!['id'],
      };

  factory MateriaModel.fromMap(Map<String, dynamic> json) => MateriaModel(
        id: json['id'],
        nombre: json['nombre'],
        area: json['area'],
      );

  @override
  String toString() {
    return "{id: $id, nombre: $nombre, area: $area }";
  }
}
