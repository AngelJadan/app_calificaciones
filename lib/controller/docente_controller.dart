import 'package:app_calificaciones/controller/abstract_controller.dart';
import 'package:app_calificaciones/models/materia_curso_docente_model.dart';
import 'package:app_calificaciones/services/remote/materia_curso_docente_service.dart';
import 'package:get/get.dart';

class DocenteController extends AbstractController<MateriaCursoDocenteService,
    MateriaCursoDocente> {
  DocenteController() : super(MateriaCursoDocente.new);
  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  init() async {
    change(null, status: RxStatus.loading());
    await getListCursos();
    change(lists, status: RxStatus.success());
  }

  getListCursos() async {
    lists = await service.listDocenteCursos();
  }
}
