import 'package:app_calificaciones/controller/abstract_controller.dart';
import 'package:app_calificaciones/models/materia_model.dart';
import 'package:app_calificaciones/services/remote/materia_service.dart';
import 'package:get/get.dart';

class MateriaController
    extends AbstractController<MateriaService, MateriaModel> {
  MateriaController() : super(MateriaModel.new);

  List<Map> areas = [];

  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  init() async {
    change(null, status: RxStatus.loading());
    await getAreas();
    await getMaterias();
    change(lists, status: RxStatus.success());
  }

  delete(MateriaModel materia) async {
    change(lists, status: RxStatus.loading());
    if (await service.remove(materia)) {
      lists.removeWhere((element) => element == materia);
    }
    change(lists, status: RxStatus.success());
  }

  getMaterias() async {
    lists = await service.getAll();
  }

  getAreas() async {
    areas = await service.listArea();
  }

  save(MateriaModel? materia) async {
    change(lists, status: RxStatus.loading());
    if (materia!.id != null) {
      MateriaModel materiaUpdated = await service.update(materia);
      lists.removeWhere((element) => element.id == materia.id);
      lists.add(materiaUpdated);
    } else {
      MateriaModel newMateria = await service.create(materia);
      lists.add(newMateria);
    }
    change(lists, status: RxStatus.success());
  }
}
