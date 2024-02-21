import 'package:app_calificaciones/controller/abstract_controller.dart';
import 'package:app_calificaciones/models/persona_model.dart';
import 'package:app_calificaciones/services/remote/persona_service.dart';
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
            child: Container(height: 700, child: child),
          ));
        },
      );

      if (pickedInitDate != null && pickedInitDate != now) {
        now.value = pickedInitDate;
      }
    } catch (e) {
      print(e);
    }
  }

  saveFuncionario() async {
    object.value.nombre = nombreController.text;
    object.value.apellido = apellidoController.text;
    object.value.nombreUsuario =
        "${object.value.nombre}_${object.value.apellido}";
    object.value.correo = correoController.text;
    object.value.identificacion = identificacionController.text;
    PersonaModel newPersona = await service.create(object.value);
    lists.add(newPersona);
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
    update(['idTipoDoc']);
  }
}
