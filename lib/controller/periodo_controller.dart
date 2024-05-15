import 'package:app_calificaciones/controller/abstract_controller.dart';
import 'package:app_calificaciones/models/periodo_model.dart';
import 'package:app_calificaciones/services/remote/periodo_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';

class PeriodoController
    extends AbstractController<PeriodoService, PeriodoModel> {
  PeriodoController() : super(PeriodoModel.new);

  int index = 0;
  final now = DateTime.now().obs;

  @override
  onInit() {
    super.onInit();
    init();
  }

  @override
  init() async {
    index = 0;
    change(null, status: RxStatus.loading());
    await getPeriodos();
    change(lists, status: RxStatus.success());
  }

  getPeriodos() async {
    lists = await service.allList();
  }

  chooseDateInicioPeriodo() async {
    try {
      DateTime? pickedInitDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime(
            (now.value.year), DateTime.now().month, DateTime.now().day),
        firstDate: DateTime((now.value.year - 1)),
        lastDate: DateTime(
            (now.value.year), DateTime.now().month, DateTime.now().day),
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
        object.value.inicioPeriodo = pickedInitDate;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  chooseDateFinPeriodo() async {
    try {
      DateTime? pickedInitDate = await showDatePicker(
        context: Get.context!,
        initialDate:
            DateTime(now.value.year, DateTime.now().month, DateTime.now().day),
        firstDate: DateTime(now.value.year - 1),
        lastDate: DateTime(
            (now.value.year), DateTime.now().month, DateTime.now().day),
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
        object.value.cierrePeriodo = pickedInitDate;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  validarFechas() {
    int diferencia = object.value.inicioPeriodo!
        .difference(object.value.cierrePeriodo!)
        .inDays;
    int diferenciaMeses = (diferencia / 30).round();
    if (diferenciaMeses > -3) {
      throw Exception({
        "fecha":
            "La fecha inicial debe ser menor a 2 meses a la fecha de cierre."
      });
    }
  }

  viewEdit({PeriodoModel? periodoModel}) {
    if (kDebugMode) {
      print("periodo ${periodoModel.toString()}");
    }
    setObject(periodoModel?.id);
    if (periodoModel == null) {
      object.value.inicioPeriodo = now.value;
      object.value.cierrePeriodo = now.value;
      object.value.periodoAbierto = true;
    }
    var periodoController = TextEditingController(
        text: object.value.periodo != null
            ? object.value.periodo.toString()
            : "");
    RxBool abierto = true.obs;
    object.value.periodoAbierto != null
        ? abierto.value = object.value.periodoAbierto!
        : null;

    Get.defaultDialog(
        title: "Nuevo periodo",
        content: Form(
          key: formKeyCliente,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                width: 200,
                child: TextFormField(
                  controller: periodoController,
                  decoration: const InputDecoration(
                    labelText: "Periodo",
                  ),
                  validator: (value) =>
                      value!.isEmpty || !RegExp(r'^\d*$').hasMatch(value)
                          ? "(Ingre solo numeros positivos)"
                          : null,
                  onChanged: (value) {
                    object.value.periodo = int.parse(value);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                width: 200,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (abierto.value) {
                      abierto.value = false;
                      object.value.periodoAbierto = false;
                    } else {
                      abierto.value = true;
                      object.value.periodoAbierto = true;
                    }
                  },
                  icon: Obx(
                    () => Icon(
                      abierto.value
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: abierto.value ? Colors.green : Colors.red,
                    ),
                  ),
                  label: const Text("Periodo abierto"),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                child: ElevatedButton.icon(
                  onPressed: () {
                    chooseDateInicioPeriodo();
                  },
                  icon: const Icon(Icons.calendar_month),
                  label: Obx(() => Text(object.value.inicioPeriodo != null
                      ? "Inicio: ${object.value.inicioPeriodo!.year}/${object.value.inicioPeriodo!.month}/${object.value.inicioPeriodo!.day}"
                      : "Inicio: yyyy/mm/dd")),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                child: ElevatedButton.icon(
                  onPressed: () {
                    chooseDateFinPeriodo();
                  },
                  icon: const Icon(Icons.calendar_month),
                  label: Obx(() => Text(object.value.inicioPeriodo != null
                      ? "Fin: ${object.value.cierrePeriodo!.year}/${object.value.cierrePeriodo!.month}/${object.value.cierrePeriodo!.day}"
                      : "Fin: yyyy/mm/dd")),
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (formKeyCliente.currentState!.validate()) {
                save();
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text(
              "Guardar",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(Get.context!).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text(
              "Cancelar",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]);
  }

  delete(PeriodoModel periodo) async {
    change(lists, status: RxStatus.loading());
    bool? res = await service.delete(periodo);
    if (res) {
      lists.removeWhere((element) => element.id == periodo.id);
      MotionToast.success(
              description: const Text("Periodo eliminado satisfactoriamente"))
          .show(Get.context!);
    }
    change(lists, status: RxStatus.success());
  }

  save() async {
    change(lists, status: RxStatus.loading());
    try {
      validarFechas();
      if (object.value.id == null) {
        PeriodoModel res = await service.create(object.value);
        lists.add(res);
        Get.back();
        MotionToast.success(description: const Text("Periodo creado"))
            .show(Get.context!);
      } else {
        PeriodoModel res = await service.update(object.value);
        lists.removeWhere((element) => element.id == res.id);
        lists.add(res);
        Get.back();
        MotionToast.success(description: const Text("Periodo actualizado"))
            .show(Get.context!);
      }
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        content: Text(
          e.toString(),
        ),
        onConfirm: () => Get.back(),
      );
    }
    change(lists, status: RxStatus.success());
  }

  getDataRow(PeriodoModel periodo) {
    return [
      DataCell(Text("${periodo.periodo}")),
      DataCell(periodo.periodoAbierto!
          ? const Row(
              children: [
                Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                Text(
                  "Abierto",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ],
            )
          : const Row(
              children: [
                Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                Text(
                  "Cerrado",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ],
            )),
      DataCell(Text(
          "${periodo.inicioPeriodo!.year}/${periodo.inicioPeriodo!.month}/${periodo.inicioPeriodo!.day}")),
      DataCell(
        Text(periodo.cierrePeriodo != null
            ? "${periodo.cierrePeriodo!.year}/${periodo.cierrePeriodo!.month}/${periodo.cierrePeriodo!.day}"
            : ""),
      ),
      DataCell(
        Row(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              child: IconButton(
                onPressed: () {
                  viewEdit(periodoModel: periodo);
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.amber,
                ),
                tooltip: "Editar",
              ),
            ),
            IconButton(
              onPressed: () {
                delete(periodo);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              tooltip: "Eliminar",
            ),
          ],
        ),
      ),
    ];
  }
}
