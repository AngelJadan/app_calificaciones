import 'package:app_calificaciones/controller/abstract_controller.dart';
import 'package:app_calificaciones/models/persona_model.dart';
import 'package:app_calificaciones/services/remote/persona_service.dart';
import 'package:app_calificaciones/views/funcionario/funcionario_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FuncionarioController
    extends AbstractController<PersonaService, PersonaModel> {
  bool loading = true;
  final _funcionarioService = PersonaService();

  TextEditingController nombreController = TextEditingController(text: "");
  TextEditingController apellidoController = TextEditingController(text: "");
  TextEditingController identificacionController =
      TextEditingController(text: "");
  TextEditingController correoController = TextEditingController(text: "");

  List<String> tipoDocumentos = <String>['Cedula', 'Pasaporte'];
  String documentoSeleccionado = "Cedula";

  FuncionarioController() : super(PersonaModel.new);

  final now = DateTime.now().obs;

  @override
  onInit() {
    super.onInit();
    init();
  }

  @override
  init() async {
    loading = false;
    setObject(null);
    object.value = PersonaModel();
    object.value.tipo = "1";
    object.value.fechaIngreso = now.value;
    await getFuncionarios();
    update();
  }

  chooseDateInit() async {
    try {
      DateTime? pickedInitDate = await showDatePicker(
        context: Get.context!,
        initialDate: object.value.fechaIngreso,
        firstDate: DateTime(now.value.year),
        lastDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        helpText: 'Seleccionar',
        confirmText: 'Confirmar',
        errorFormatText: 'Formato de texto invalido',
        errorInvalidText: 'Ingrese una fecha de rango valido. ',
        //initialEntryMode: DatePickerEntryMode.input,
        initialDatePickerMode: DatePickerMode.day,
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
        now.value = pickedInitDate;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  int index = 0;
  DataRow mapping(PersonaModel persona) {
    index++;
    return DataRow(
      onSelectChanged: (value) {},
      cells: [
        DataCell(
          Text(index.toString()),
        ),
        DataCell(
          Text(persona.nombre.toString()),
        ),
        DataCell(
          Text(persona.apellido.toString()),
        ),
        DataCell(
          Text(persona.identificacion.toString()),
        ),
        DataCell(
          Text(persona.correo.toString()),
        ),
        DataCell(
          Text(
              "${persona.fechaIngreso!.year}/${persona.fechaIngreso!.month}/${persona.fechaIngreso!.day}"),
        ),
        DataCell(
          Text(persona.getTipo(persona.tipo!)),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () {
                  const FuncionarioPage().newFuncionario(persona);
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.amber,
                ),
                tooltip: "Editar",
              ),
              IconButton(
                onPressed: () {
                  deleteFuncionario(persona);
                },
                icon: const Icon(
                  Icons.remove_circle,
                  color: Color.fromARGB(255, 238, 16, 0),
                ),
                tooltip: "Eliminar",
              ),
            ],
          ),
        ),
      ],
    );
  }

  saveFuncionario() async {
    change(null, status: RxStatus.loading());
    object.value.nombre = nombreController.text;
    object.value.apellido = apellidoController.text;
    object.value.nombreUsuario =
        "${object.value.nombre}_${object.value.apellido}";
    object.value.correo = correoController.text;
    object.value.identificacion = identificacionController.text;
    object.value.tipoIdetificacion = documentoSeleccionado;
    if (object.value.id == null) {
      PersonaModel newPersona = await service.create(object.value);
      lists.add(newPersona);
    } else {
      PersonaModel newPersona = await service.update(object.value);
      lists.removeWhere((element) => element.id == newPersona.id);
      lists.add(object.value);
    }
    change(lists, status: RxStatus.success());
  }

  deleteFuncionario(PersonaModel persona) async {
    var res = await service.remove(persona);
    if (kDebugMode) {
      print("res $res");
    }
  }

  getFuncionarios() async {
    lists = await _funcionarioService.getAll();
  }

  cleanData() {
    nombreController.text = "";
    apellidoController.text = "";
    identificacionController.text = "";
    correoController.text = "";
  }

  selectTipoDocumento(String tipoDocumento) {
    documentoSeleccionado = tipoDocumento;
    object.value.tipoIdetificacion = "1";
    update(['idTipoDoc']);
  }
  
}
