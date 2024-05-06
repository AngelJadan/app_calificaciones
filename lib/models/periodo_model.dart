import 'package:app_calificaciones/models/abstract_model.dart';

class PeriodoModel extends AbstractModel<int> {
  PeriodoModel({
    id,
    this.periodo,
    this.periodoAbierto,
    this.inicioPeriodo,
    this.cierrePeriodo,
  }) : super(id);

  int? periodo;
  bool? periodoAbierto;
  DateTime? inicioPeriodo;
  DateTime? cierrePeriodo;

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "periodo": periodo,
        "periodo_abierto": periodoAbierto,
        "inicio_periodo":
            "${inicioPeriodo!.year}-${inicioPeriodo!.month}-${inicioPeriodo!.day}",
        "cierre_periodo": cierrePeriodo != null
            ? "${cierrePeriodo!.year}-${cierrePeriodo!.month}-${cierrePeriodo!.day}"
            : null,
      };

  factory PeriodoModel.fromMap(Map<String, dynamic> json) => PeriodoModel(
        id: json['id'],
        periodo: json['periodo'],
        periodoAbierto: json['periodo_abierto'],
        inicioPeriodo: DateTime.parse(json['inicio_periodo']),
        cierrePeriodo: DateTime.parse(json['cierre_periodo']),
      );

  @override
  String toString() {
    return "{ id: $id, periodo: $periodo, inicioPeriodo: $inicioPeriodo, cierrePeriodo: $cierrePeriodo }";
  }
}
