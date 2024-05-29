import 'package:app_calificaciones/models/abstract_model.dart';
import 'package:app_calificaciones/models/calificacion_estudiante/trimestre_cabecera_model.dart';

class TrimestreDetalleCalificacion extends AbstractModel<int> {
  TrimestreDetalleCalificacion({
    id,
    this.aporte,
    this.actividad,
    this.item,
    this.calificacion,
    this.trimestre,
  }) : super(id);

  int? aporte;
  int? actividad;
  int? item;
  int? calificacion;
  CabeceraTrimestreModel? trimestre;

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "aporte": aporte,
        "actividad": actividad,
        "item": item,
        "calificacion": calificacion
      };

  factory TrimestreDetalleCalificacion.fromMap(Map<String, dynamic> json) =>
      TrimestreDetalleCalificacion(
        id: json['id'],
        aporte: int.parse(json['aporte']),
        actividad: int.parse(json['actividad']),
        item: json['item'],
        calificacion: int.parse(json['calificacion']),
        trimestre: CabeceraTrimestreModel(id: json['id']),
      );
  @override
  String toString() {
    return "{id: $id, aporte: $aporte, actividad: $actividad, item: $item, calificacion: $calificacion}";
  }
}
