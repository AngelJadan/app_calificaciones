import 'package:app_calificaciones/models/abstract_model.dart';
import 'package:app_calificaciones/models/estudiante_model.dart';
import 'package:app_calificaciones/models/materia_curso_docente_model.dart';

class MateriaEstudianteModel extends AbstractModel<int> {
  MateriaEstudianteModel({
    id,
    this.estudiante,
    this.materiaCursoDocente,
  }) : super(id);

  EstudianteModel? estudiante;
  MateriaCursoDocente? materiaCursoDocente;

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "estudiante": estudiante!.id,
        "materia_curso": materiaCursoDocente!.id,
      };

  factory MateriaEstudianteModel.fromMap(Map<String, dynamic> json) =>
      MateriaEstudianteModel(
        id: json['id'],
        estudiante: EstudianteModel.fromMap(json['estudiante']),
        // materiaCursoDocente: MateriaCursoDocente.froMap(json['materia_curso']),
      );

  @override
  String toString() {
    return "{id: $id, estudiante: $estudiante, materiaCursoDocente: $materiaCursoDocente }";
  }
}
