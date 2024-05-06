import 'package:app_calificaciones/controller/abstract_controller.dart';
import 'package:app_calificaciones/models/curso_model.dart';
import 'package:app_calificaciones/models/materia_curso_docente_model.dart';
import 'package:app_calificaciones/models/materia_model.dart';
import 'package:app_calificaciones/models/periodo_model.dart';
import 'package:app_calificaciones/models/persona_model.dart';
import 'package:app_calificaciones/services/remote/curso_service.dart';
import 'package:app_calificaciones/services/remote/materia_curso_docente_service.dart';
import 'package:app_calificaciones/services/remote/materia_service.dart';
import 'package:app_calificaciones/services/remote/periodo_service.dart';
import 'package:app_calificaciones/services/remote/persona_service.dart';
import 'package:get/get.dart';

class MateriaCursoDocenteController extends AbstractController<
    MateriaCursoDocenteService, MateriaCursoDocente> {
  MateriaCursoDocenteController() : super(MateriaCursoDocente.new);

  List<CursoModel> cursos = [];
  List<PersonaModel> docentes = [];
  List<MateriaModel> materias = [];
  PeriodoModel? periodo;

  final materiaService = Get.find<MateriaService>();
  final cursoService = Get.find<CursoService>();
  final periodoService = Get.find<PeriodoService>();
  final personaService = Get.find<PersonaService>();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  init() async {
    change(null, status: RxStatus.loading());
    await getCursos();
    await getLastPeriodo();
    await getDocentes();
    await getMateria();
    await listCursoMateriaDocente();
    change(lists, status: RxStatus.success());
  }

  save(MateriaCursoDocente materiaCursoDocente) async {
    change(lists, status: RxStatus.loading());
    if (materiaCursoDocente.id == null) {
      print("creando: ${materiaCursoDocente.toJson()}");
      var res = await service.create(materiaCursoDocente);
      if (res.id != null) {
        lists.add(res);
      }
    } else {
      var res = await service.update(materiaCursoDocente);
      if (res.id != null) {
        lists.removeWhere((element) => element.id == materiaCursoDocente.id);
        lists.add(res);
      }
    }

    change(lists, status: RxStatus.success());
  }

  listCursoMateriaDocente() async {
    lists = await service.allList();
  }

  delete(MateriaCursoDocente object) async {
    change(lists, status: RxStatus.loading());
    var res = await service.delete(object);
    if (res) {
      lists.removeWhere((element) => element.id == object.id);
    }
    change(lists, status: RxStatus.success());
  }

  getCursos() async {
    cursos = await cursoService.listCurso();
    //cursos.add(CursoModel(id: 0, nombre: "Seleccionar"));
  }

  getLastPeriodo() async {
    periodo = await periodoService.lastPeriodo();
  }

  getDocentes() async {
    docentes = await personaService.getAll();
  }

  getMateria() async {
    materias = await materiaService.getAll();
  }
}
