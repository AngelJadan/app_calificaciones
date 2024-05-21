import 'package:app_calificaciones/controller/abstract_controller.dart';
import 'package:app_calificaciones/models/materia_curso_docente_model.dart';
import 'package:app_calificaciones/models/periodo_model.dart';
import 'package:app_calificaciones/services/remote/materia_curso_docente_service.dart';
import 'package:app_calificaciones/services/remote/periodo_service.dart';
import 'package:get/get.dart';

class CursoPeriodoController extends AbstractController<
    MateriaCursoDocenteService, MateriaCursoDocente> {
  CursoPeriodoController() : super(MateriaCursoDocente.new);

  List<PeriodoModel> periodos = [];
  PeriodoModel? periodo;

  final _periodoService = Get.find<PeriodoService>();

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
    init();
  }

  @override
  init() async {
    change(null, status: RxStatus.loading());
    await getPeriodos();
    if (periodo != null) {
      await getCursosPeriodo();
    }
    change(lists, status: RxStatus.success());
  }

  getPeriodos() async {
    periodos = await _periodoService.allList();
    periodo = periodos.last;
  }

  getCursosPeriodo() async {
    lists = await service.listCursoToPeriodo(periodo!);
  }
}
