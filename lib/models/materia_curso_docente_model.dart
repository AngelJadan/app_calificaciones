import 'package:app_calificaciones/models/abstract_model.dart';
import 'package:app_calificaciones/models/curso_model.dart';
import 'package:app_calificaciones/models/materia_curso_model.dart';
import 'package:app_calificaciones/models/materia_model.dart';
import 'package:app_calificaciones/models/periodo_model.dart';
import 'package:app_calificaciones/models/persona_model.dart';

class MateriaCursoDocente extends AbstractModel<int> {
  MateriaCursoDocente({
    id,
    this.curso,
    this.materia,
    this.periodo,
    this.docente,
    this.estudiantes,
  }) : super(id);

  CursoModel? curso;
  MateriaModel? materia;
  PeriodoModel? periodo;
  PersonaModel? docente;
  List<MateriaEstudianteModel>? estudiantes;

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "curso": curso!.id,
        "materia": materia!.id,
        "periodo_lectivo": periodo!.id,
        "docente": docente!.id,
      };

  factory MateriaCursoDocente.froMap(Map<String, dynamic> json) =>
      MateriaCursoDocente(
        id: json["id"],
        curso: CursoModel.fromMap(json['curso']),
        materia: MateriaModel.fromMap(json['materia']),
        periodo: PeriodoModel.fromMap(json['periodo_lectivo']),
        docente: PersonaModel.fromMap(json['docente']),
        estudiantes: (json['materia_curso'] as List)
            .map((e) => MateriaEstudianteModel.fromMap(e))
            .toList(),
      );

  @override
  String toString() {
    return "{ id: $id, curso: ${curso.toString()}, materia: ${materia.toString()}, periodo: ${periodo.toString()}, docente: ${docente.toString()}}";
  }
}
