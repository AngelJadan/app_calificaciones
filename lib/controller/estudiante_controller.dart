import 'package:app_calificaciones/controller/abstract_controller.dart';
import 'package:app_calificaciones/models/curso_model.dart';
import 'package:app_calificaciones/models/estudiante_model.dart';
import 'package:app_calificaciones/services/remote/estudiante_service.dart';
import 'package:app_calificaciones/views/estudiante/estudiante_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class EstudianteController
    extends AbstractController<EstudianteService, EstudianteModel> {
  EstudianteController() : super(EstudianteModel.new);

  final now = DateTime.now().obs;
  String documentoSeleccionado = "Cedula";

  List<String> tipoDocumentos = <String>['Cedula', 'Pasaporte'];
  List<CursoModel> cursos = [];
  CursoModel? cursoSelected;
  int index = 0;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  init() async {
    try {
      change(null, status: RxStatus.loading());
      setObject(null);
      object.value.fechaNacimiento = now();
      await getEstudiantes();
      //await getCursos();
      change(lists, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  /*
  GetBuilder(
                  init: EstudianteController(),
                  id: "idCurso",
                  builder: (_) => DropdownButton<CursoModel>(
                    value: controller.cursoSelected,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (CursoModel? value) {
                      controller.selectCursoModel(value!);
                    },
                    items: controller.cursos
                        .map<DropdownMenuItem<CursoModel>>((CursoModel value) {
                      return DropdownMenuItem<CursoModel>(
                        value: value,
                        child: Text(
                            "${value.nombre} ${value.paralelo!['nombre']}"),
                      );
                    }).toList(),
                  ),
                ),

  getCursos() async {
    cursos = await _cursoService.listCurso();
  }
*/
  getEstudiantes() async {
    index = 0;
    lists = await service.getAll();
  }

  delete(EstudianteModel estudiante) async {
    bool res = await service.delete(estudiante);
    if (res) {
      lists.remove(estudiante);
      update();
      Navigator.of(Get.context!).pop();
    }
  }

  chooseDateInit() async {
    try {
      DateTime? pickedInitDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime(
            (now.value.year - 3), DateTime.now().month, DateTime.now().day),
        firstDate: DateTime((now.value.year - 30)),
        lastDate: DateTime(
            (now.value.year - 2), DateTime.now().month, DateTime.now().day),
        helpText: 'Seleccionar',
        confirmText: 'Confirmar',
        errorFormatText: 'Formato de texto invalido',
        errorInvalidText: 'Ingrese una fecha de rango valido. ',
        //initialEntryMode: DatePickerEntryMode.input,
        initialDatePickerMode: DatePickerMode.year,
        builder: (context, child) {
          return Scrollbar(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(height: 700, child: child),
          ));
        },
      );

      // ignore: unrelated_type_equality_checks
      if (pickedInitDate != null && pickedInitDate != now) {
        object.value.fechaNacimiento = pickedInitDate;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  DataRow mappingList(EstudianteModel estudiante) {
    index++;
    return DataRow(
      onSelectChanged: (value) {},
      cells: [
        DataCell(
          Text("$index"),
        ),
        DataCell(
          Text("${estudiante.nombre}"),
        ),
        DataCell(
          Text("${estudiante.apellido}"),
        ),
        DataCell(
          Text("${estudiante.correo}"),
        ),
        DataCell(
          Text("${estudiante.identificacion}"),
        ),
        DataCell(
          Text(estudiante.getTipoDocumento(estudiante.tipoIdetificacion!)),
        ),
        DataCell(
          Text(
              "${estudiante.fechaNacimiento!.year}-${estudiante.fechaNacimiento!.month}-${estudiante.fechaNacimiento!.day}"),
        ),
        DataCell(Row(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              child: IconButton(
                onPressed: () {
                  EstudiantePage().dialogEstudiante(estudiante);
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.amber,
                ),
                tooltip: "Editar",
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: Get.context!,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Center(
                        child: Text("Confirmar"),
                      ),
                      content: const Text("¿Esta seguro de eliminar?"),
                      actions: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () {
                              delete(estudiante);
                            },
                            child: const Text(
                              "Confirmar",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Cancelar",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
                tooltip: "Eliminar",
              ),
            )
          ],
        )),
      ],
    );
  }

  selectTipoDocumento(String tipoDocumento) {
    documentoSeleccionado = tipoDocumento;
    update(['idTipoDoc']);
  }

  selectCursoModel(CursoModel curso) {
    cursoSelected = curso;
    update(['idCurso']);
  }

  saveEstudiante(int? id, EstudianteModel? estudiante) async {
    if (id == null) {
      object.value = await service.create(estudiante!);
      lists.add(object.value);
      Fluttertoast.showToast(
        msg: "Estudiante creado.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
        webPosition: "center",
      );
      Navigator.of(Get.context!).pop();
    }
    if (id != null) {
      bool res = await service.update(estudiante!);
      if (res) {
        Fluttertoast.showToast(
          msg: "Estudiante actualizado.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
          webPosition: "center",
        );
        lists.removeWhere((element) => element.id == estudiante.id);
        lists.add(estudiante);
        Navigator.of(Get.context!).pop();
      }
    }
    index = 0;
    update();
  }
}
