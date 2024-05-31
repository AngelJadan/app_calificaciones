// ignore_for_file: unnecessary_null_comparison

import 'package:app_calificaciones/controller/abstract_controller.dart';
import 'package:app_calificaciones/models/calificacion_estudiante/estudiante_materia_models.dart';
import 'package:app_calificaciones/models/calificacion_estudiante/trimestre_cabecera_model.dart';
import 'package:app_calificaciones/models/calificacion_estudiante/trimestre_detalle_calificacion.dart';
import 'package:app_calificaciones/models/estudiante_model.dart';
import 'package:app_calificaciones/models/login_model.dart';
import 'package:app_calificaciones/models/materia_curso_docente_model.dart';
import 'package:app_calificaciones/models/materia_curso_model.dart';
import 'package:app_calificaciones/services/local/authentication.dart';
import 'package:app_calificaciones/services/remote/estudiante_service.dart';
import 'package:app_calificaciones/services/remote/materia_estudiante_service.dart';
import 'package:app_calificaciones/services/remote/trimestre_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

class CursoEstudianteController extends AbstractController<
    MateriaEstudianteService, MateriaEstudianteModel> {
  CursoEstudianteController() : super(MateriaEstudianteModel.new);

  final serviceEstudiante = Get.find<EstudianteService>();
  final serviceTrimestre = Get.find<TrimestreService>();
  MateriaCursoDocente? materiaCursoDocente;
  EstudianteMateriaModel? estudianteMateria;
  SessionProvider localAuthRepository = SessionProvider();
  LoginModel? session;
  final args = Get.arguments;
  late PlutoGridStateManager stateManager;
  List<int> trimestres = [1, 2];
  int trimestre = 1;

  List<EstudianteModel> estudiantes = [];

  final List<PlutoColumn> columns = [];
  final List<PlutoColumnGroup> columnGroup = [];
  List<PlutoRow> rows = [];

  final Color backgroundLecciones = Colors.amber;
  final Color backgroundPruebas = Colors.green;
  final Color backgroundTareas = const Color.fromARGB(255, 145, 205, 255);

  final Color backgroundProyecto = const Color.fromARGB(255, 251, 218, 118);
  final Color backgroundExposicion = Colors.green;
  final Color backgroundTaller = const Color.fromARGB(255, 145, 205, 255);

  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  init() async {
    change(null, status: RxStatus.loading());
    if (args != null) {
      session = await localAuthRepository.getSession();
      final arguments = Get.arguments as Map<String, dynamic>;
      //debugPrint("arguments $arguments");
      //debugPrint("arguments['curso'] ${arguments['curso']}");
      materiaCursoDocente = arguments['curso'];
      await getCalificacionesTrimestre(arguments['curso'].id, 1);
      materiaCursoDocente = arguments['curso'];

      setObject(null);
    }
    addPlutoGroup();
    change(lists, status: RxStatus.success());
  }

  getCalificacionesTrimestre(int idMateriaCursoDocente, int trimestre) async {
    lists =
        await service.getMateriaEstudiante(idMateriaCursoDocente, trimestre);
    rows = getRows();
  }

  updateGetCalificaion(int idMateriaCursoDocente) async {
    change(null, status: RxStatus.loading());
    await getCalificacionesTrimestre(idMateriaCursoDocente, trimestre);

    change(lists, status: RxStatus.success());
  }

  ///Suma las calificaciones para devolver el valor del cualitativo.
  String sumaCualitativo(int indexRow, String field) {
    int totalCualitativo = 0;

    for (int i = 1; i <= 3; i++) {
      totalCualitativo = totalCualitativo +
          int.parse(rows[indexRow].cells["$field$i"]!.value.toString());
    }

    totalCualitativo = totalCualitativo ~/ 3;
    return totalCualitativo == 3
        ? "A"
        : totalCualitativo == 2
            ? "EP"
            : totalCualitativo == 1
                ? "I"
                : "NE";
  }

  ///Actualiza el valor cualitativo.
  sumaCualitativos(int indexRow, int column) {
    if (column >= 1 && column <= 3) {
      updateCell(indexRow, 'leccion_cualitativo',
          sumaCualitativo(indexRow, "leccion"));
    }
    if (column >= 5 && column <= 7) {
      updateCell(
          indexRow, 'prueba_cualitativo', sumaCualitativo(indexRow, 'prueba'));
    }
    if (column >= 9 && column <= 11) {
      updateCell(
          indexRow, 'tarea_cualitativo', sumaCualitativo(indexRow, 'tarea'));
    }
    if (column >= 13 && column <= 15) {
      updateCell(indexRow, 'proyecto_cualitativo',
          sumaCualitativo(indexRow, 'proyecto'));
    }
    if (column >= 17 && column <= 19) {
      updateCell(indexRow, 'exposicion_cualitativo',
          sumaCualitativo(indexRow, 'exposicion'));
    }
    if (column >= 21 && column <= 23) {
      updateCell(
          indexRow, 'taller_cualitativo', sumaCualitativo(indexRow, 'taller'));
    }
  }

  updateCell(int indexRow, String field, dynamic value) {
    rows[indexRow].cells[field]!.value = value;
    stateManager.notifyListeners();
  }

  setNewCalificacion(
      int columnIndex, int rowIndex, int calificacion, BuildContext context) {
    if (columnIndex > 0) {
      sumaCualitativos(rowIndex, columnIndex);
    }
  }

  getTrimestre() {
    int numeroTrimestre = 1;
    for (var i = 0; i < lists.length; i++) {
      CabeceraTrimestreModel? trimestre = lists[i].trimestres != null &&
              lists[i].trimestres!.isNotEmpty
          ? lists[i]
              .trimestres!
              .where((element) => element.numeroTrimestre == numeroTrimestre)
              .first
          : null;
      trimestre ??= CabeceraTrimestreModel(
        numeroTrimestre: numeroTrimestre,
        materiaEstudiante: lists[i],
        detalleCalificacion: [],
      );

      List<TrimestreDetalleCalificacion> calificaciones = [];
      List<TrimestreDetalleCalificacion> lecciones =
          getCafilicaciones(i, "leccion", 1, 1);

      List<TrimestreDetalleCalificacion> pruebas =
          getCafilicaciones(i, "prueba", 1, 2);

      List<TrimestreDetalleCalificacion> tareas =
          getCafilicaciones(i, "tarea", 1, 3);

      List<TrimestreDetalleCalificacion> proyectos =
          getCafilicaciones(i, "proyecto", 2, 1);

      List<TrimestreDetalleCalificacion> exposiciones =
          getCafilicaciones(i, "exposicion", 2, 2);

      List<TrimestreDetalleCalificacion> talleres =
          getCafilicaciones(i, "taller", 2, 3);

      calificaciones.addAll(lecciones);
      calificaciones.addAll(pruebas);
      calificaciones.addAll(tareas);
      calificaciones.addAll(proyectos);
      calificaciones.addAll(exposiciones);
      calificaciones.addAll(talleres);

      trimestre.aporteCualitativo = rows[i].cells['aporte_cualitativo']!.value;
      trimestre.proyectoIntegrador =
          rows[i].cells['proyecto_integrador']!.value;
      trimestre.cualitativoProyectoIntegrador =
          rows[i].cells['cualitativo_proyecto_integrador']!.value;
      trimestre.detalleCalificacion = calificaciones;

      if (lists[i].trimestres == null || lists[i].trimestres!.isEmpty) {
        lists[i].trimestres = [];
        lists[i].trimestres!.add(trimestre);
      } else {
        CabeceraTrimestreModel oldTrimestre = lists[i].trimestres!.firstWhere(
            (element) => element.numeroTrimestre == trimestre!.numeroTrimestre);
        trimestre.id = oldTrimestre.id;
        lists[i].trimestres!.remove(oldTrimestre);
        lists[i].trimestres!.add(trimestre);
      }
      //var row = rows[i].cells['leccion1']!.value;
      //debugPrint("row: $row");
    }
  }

  List<TrimestreDetalleCalificacion> getCafilicaciones(
      int indexRow, String field, int aporte, int actividad) {
    List<TrimestreDetalleCalificacion> calificaciones = [];
    for (var i = 1; i <= 3; i++) {
      TrimestreDetalleCalificacion calificacion =
          getCalificacionList(indexRow, "$field$i", aporte, actividad, i);
      calificaciones.add(calificacion);
    }

    TrimestreDetalleCalificacion calificacionCualitativo =
        TrimestreDetalleCalificacion(
      aporte: aporte,
      actividad: actividad,
      item: 4,
      calificacion: 0,
    );
    int valor = 0;
    for (var element in calificaciones) {
      valor = valor + element.calificacion!;
    }
    calificacionCualitativo.calificacion = valor ~/ 3;
    calificaciones.add(calificacionCualitativo);
    return calificaciones;
  }

  ///@param indexRow
  ///@param field 'leccion', 'prueba', 'tarea', 'proyecto', 'exposicion', 'taller'
  ///@param aporte 1: Individual, 2: Grupal
  ///@param actividad 1: Lecciones, 2: Pruebas, 3: Tareas, 4: Proyectos, 5: Exposiciones, 6: Talleres
  TrimestreDetalleCalificacion getCalificacionList(
      int indexRow, String field, int aporte, int actividad, int item) {
    var calificacion = rows[indexRow].cells[field]!.value;
    if (calificacion.runtimeType == String) {
      if (calificacion == "A") {
        calificacion = 3;
      }
      if (calificacion == "EP") {
        calificacion = 2;
      }
      if (calificacion == "I") {
        calificacion = 1;
      } else {
        calificacion = 0;
      }
    }

    return TrimestreDetalleCalificacion(
      aporte: aporte,
      actividad: actividad,
      item: item,
      calificacion: calificacion,
    );
  }

  saveCalificacion(CabeceraTrimestreModel object) async {
    object.usuario = session!.id;
    object.id == null
        ? await serviceTrimestre.create(object)
        : await serviceTrimestre.update(object);
  }

  save(MateriaEstudianteModel object) async {
    object.materiaCursoDocente = materiaCursoDocente;
    await service.create(object);
  }

  addPlutoGroup() {
    columnGroup.addAll(
      [
        PlutoColumnGroup(
          title: "1° TRIMESTRE",
          children: [
            PlutoColumnGroup(
              title:
                  "APORTES: Actividades Disciplinares o Interdisciplinares individuales",
              children: [
                PlutoColumnGroup(
                  title: 'LECCIONES ORALES/ESCRITAS',
                  backgroundColor: backgroundLecciones,
                  children: [
                    PlutoColumnGroup(
                      title: '0/3',
                      backgroundColor: backgroundLecciones,
                      children: [
                        PlutoColumnGroup(
                          backgroundColor: backgroundLecciones,
                          title: '1',
                          fields: ['leccion1'],
                        )
                      ],
                    ),
                    PlutoColumnGroup(
                      title: '0/3',
                      backgroundColor: backgroundLecciones,
                      children: [
                        PlutoColumnGroup(
                          title: '2',
                          backgroundColor: backgroundLecciones,
                          fields: ['leccion2'],
                        )
                      ],
                    ),
                    PlutoColumnGroup(
                      title: '0/3',
                      backgroundColor: backgroundLecciones,
                      children: [
                        PlutoColumnGroup(
                          title: '3',
                          backgroundColor: backgroundLecciones,
                          fields: ['leccion3'],
                        )
                      ],
                    ),
                    PlutoColumnGroup(
                      title: "",
                      backgroundColor: backgroundLecciones,
                      fields: ['leccion_cualitativo'],
                    ),
                  ],
                ),
                PlutoColumnGroup(
                  title: 'PRUEBAS BASE ESTRUCTURADA',
                  backgroundColor: Colors.green,
                  children: [
                    PlutoColumnGroup(
                      title: '0/3',
                      backgroundColor: backgroundPruebas,
                      children: [
                        PlutoColumnGroup(
                          title: '1',
                          backgroundColor: backgroundPruebas,
                          fields: ['prueba1'],
                        )
                      ],
                    ),
                    PlutoColumnGroup(
                      title: '0/3',
                      backgroundColor: backgroundPruebas,
                      children: [
                        PlutoColumnGroup(
                          title: '2',
                          backgroundColor: backgroundPruebas,
                          fields: ['prueba2'],
                        )
                      ],
                    ),
                    PlutoColumnGroup(
                      title: '0/3',
                      backgroundColor: backgroundPruebas,
                      children: [
                        PlutoColumnGroup(
                          title: '3',
                          backgroundColor: Colors.green,
                          fields: ['prueba3'],
                        )
                      ],
                    ),
                    PlutoColumnGroup(
                      title: "",
                      backgroundColor: backgroundPruebas,
                      fields: ['prueba_cualitativo'],
                    ),
                  ],
                ),
                PlutoColumnGroup(
                  title: 'TAREAS/EJERCICIOS',
                  backgroundColor: backgroundTareas,
                  children: [
                    PlutoColumnGroup(
                      title: '0/3',
                      backgroundColor: backgroundTareas,
                      children: [
                        PlutoColumnGroup(
                          title: '1',
                          backgroundColor: backgroundTareas,
                          fields: ['tarea1'],
                        )
                      ],
                    ),
                    PlutoColumnGroup(
                      title: '0/3',
                      backgroundColor: backgroundTareas,
                      children: [
                        PlutoColumnGroup(
                          title: '2',
                          backgroundColor: backgroundTareas,
                          fields: ['tarea2'],
                        )
                      ],
                    ),
                    PlutoColumnGroup(
                      title: '0/3',
                      backgroundColor: backgroundTareas,
                      children: [
                        PlutoColumnGroup(
                          title: '3',
                          backgroundColor: backgroundTareas,
                          fields: ['tarea3'],
                        )
                      ],
                    ),
                    PlutoColumnGroup(
                      title: "",
                      backgroundColor: backgroundTareas,
                      fields: ['tarea_cualitativo'],
                    ),
                  ],
                ),
              ],
            ),

            ///
            /// INICIA COLUMNA DE GRUPO
            ///
            PlutoColumnGroup(
              title:
                  "APORTES: Actividades Disciplinares o Interdisciplinares grupales",
              children: [
                PlutoColumnGroup(
                  title: 'PROYECTOS INVESTIGACIONES',
                  backgroundColor: backgroundLecciones,
                  children: [
                    PlutoColumnGroup(
                      title: '0/3',
                      backgroundColor: backgroundLecciones,
                      children: [
                        PlutoColumnGroup(
                          backgroundColor: backgroundLecciones,
                          title: '1',
                          fields: ['proyecto1'],
                        )
                      ],
                    ),
                    PlutoColumnGroup(
                      title: '0/3',
                      backgroundColor: backgroundLecciones,
                      children: [
                        PlutoColumnGroup(
                          title: '2',
                          backgroundColor: backgroundLecciones,
                          fields: ['proyecto2'],
                        )
                      ],
                    ),
                    PlutoColumnGroup(
                      title: '0/3',
                      backgroundColor: backgroundLecciones,
                      children: [
                        PlutoColumnGroup(
                          title: '3',
                          backgroundColor: backgroundLecciones,
                          fields: ['proyecto3'],
                        )
                      ],
                    ),
                    PlutoColumnGroup(
                      title: "",
                      backgroundColor: backgroundLecciones,
                      fields: ['proyecto_cualitativo'],
                    ),
                  ],
                ),
                PlutoColumnGroup(
                  title: 'EXPOSICIONES/FOROS',
                  backgroundColor: Colors.green,
                  children: [
                    PlutoColumnGroup(
                      title: '0/3',
                      backgroundColor: backgroundPruebas,
                      children: [
                        PlutoColumnGroup(
                          title: '1',
                          backgroundColor: backgroundPruebas,
                          fields: ['exposicion1'],
                        )
                      ],
                    ),
                    PlutoColumnGroup(
                      title: '0/3',
                      backgroundColor: backgroundPruebas,
                      children: [
                        PlutoColumnGroup(
                          title: '2',
                          backgroundColor: backgroundPruebas,
                          fields: ['exposicion2'],
                        )
                      ],
                    ),
                    PlutoColumnGroup(
                      title: '0/3',
                      backgroundColor: backgroundPruebas,
                      children: [
                        PlutoColumnGroup(
                          title: '3',
                          backgroundColor: Colors.green,
                          fields: ['exposicion3'],
                        )
                      ],
                    ),
                    PlutoColumnGroup(
                      title: "",
                      backgroundColor: backgroundPruebas,
                      fields: ['exposicion_cualitativo'],
                    ),
                  ],
                ),
                PlutoColumnGroup(
                  title: 'TALLERES',
                  backgroundColor: backgroundTareas,
                  children: [
                    PlutoColumnGroup(
                      title: '0/3',
                      backgroundColor: backgroundTareas,
                      children: [
                        PlutoColumnGroup(
                          title: '1',
                          backgroundColor: backgroundTareas,
                          fields: ['taller1'],
                        )
                      ],
                    ),
                    PlutoColumnGroup(
                      title: '0/3',
                      backgroundColor: backgroundTareas,
                      children: [
                        PlutoColumnGroup(
                          title: '2',
                          backgroundColor: backgroundTareas,
                          fields: ['taller2'],
                        )
                      ],
                    ),
                    PlutoColumnGroup(
                      title: '0/3',
                      backgroundColor: backgroundTareas,
                      children: [
                        PlutoColumnGroup(
                          title: '3',
                          backgroundColor: backgroundTareas,
                          fields: ['taller3'],
                        )
                      ],
                    ),
                    PlutoColumnGroup(
                      title: "",
                      backgroundColor: backgroundTareas,
                      fields: ['taller_cualitativo'],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ],
    );

    columns.addAll([
      PlutoColumn(
        title: 'Nomina',
        field: 'nomina',
        type: PlutoColumnType.text(),
      ),
    ]);

    columns.addAll([
      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'leccion1',
        backgroundColor: backgroundLecciones,
        type: PlutoColumnType.number(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'leccion2',
        backgroundColor: backgroundLecciones,
        type: PlutoColumnType.number(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: '',
        field: 'leccion3',
        backgroundColor: backgroundLecciones,
        type: PlutoColumnType.number(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: 'CUALITATIVO',
        field: "leccion_cualitativo",
        backgroundColor: backgroundLecciones,
        type: PlutoColumnType.text(),
        readOnly: true,
      ),

      ///
      ///
      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'prueba1',
        backgroundColor: backgroundPruebas,
        type: PlutoColumnType.number(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'prueba2',
        backgroundColor: backgroundPruebas,
        type: PlutoColumnType.number(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: '',
        field: 'prueba3',
        backgroundColor: backgroundPruebas,
        type: PlutoColumnType.number(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: 'CUALITATIVO',
        field: "prueba_cualitativo",
        backgroundColor: backgroundPruebas,
        type: PlutoColumnType.text(),
        readOnly: true,
      ),

      ///

      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'tarea1',
        backgroundColor: backgroundTareas,
        type: PlutoColumnType.number(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'tarea2',
        backgroundColor: backgroundTareas,
        type: PlutoColumnType.number(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: '',
        field: 'tarea3',
        backgroundColor: backgroundTareas,
        type: PlutoColumnType.number(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: 'CUALITATIVO',
        field: "tarea_cualitativo",
        backgroundColor: backgroundTareas,
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
    ]);

    columns.addAll([
      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'proyecto1',
        backgroundColor: backgroundProyecto,
        type: PlutoColumnType.number(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'proyecto2',
        backgroundColor: backgroundProyecto,
        type: PlutoColumnType.text(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: '',
        field: 'proyecto3',
        backgroundColor: backgroundProyecto,
        type: PlutoColumnType.number(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: 'CUALITATIVO',
        field: "proyecto_cualitativo",
        backgroundColor: backgroundProyecto,
        type: PlutoColumnType.text(),
        readOnly: true,
      ),

      ///
      ///
      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'exposicion1',
        backgroundColor: backgroundPruebas,
        type: PlutoColumnType.number(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'exposicion2',
        backgroundColor: backgroundPruebas,
        type: PlutoColumnType.number(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: '',
        field: 'exposicion3',
        backgroundColor: backgroundPruebas,
        type: PlutoColumnType.number(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: 'CUALITATIVO',
        field: "exposicion_cualitativo",
        backgroundColor: backgroundPruebas,
        type: PlutoColumnType.text(),
        readOnly: true,
      ),

      ///

      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'taller1',
        backgroundColor: backgroundTareas,
        type: PlutoColumnType.number(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'taller2',
        backgroundColor: backgroundTareas,
        type: PlutoColumnType.number(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: '',
        field: 'taller3',
        backgroundColor: backgroundTareas,
        type: PlutoColumnType.number(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
          width: 50,
          title: 'CUALITATIVO',
          field: "taller_cualitativo",
          backgroundColor: backgroundTareas,
          type: PlutoColumnType.text(),
          readOnly: true),
    ]);

    columns.addAll([
      PlutoColumn(
        title: 'APORTES CUALITATIVOS',
        field: 'aporte_cualitativo',
        type: PlutoColumnType.number(),
        width: 50,
      ),
    ]);
    columns.addAll([
      PlutoColumn(
        title: 'PROYECTO INTEGRADOR',
        field: 'proyecto_integrador',
        type: PlutoColumnType.number(),
        width: 50,
      ),
    ]);
    columns.addAll([
      PlutoColumn(
          title: 'CUALITATIVO PROYECTO INTEGRADOR',
          field: 'cualitativo_proyecto_integrador',
          type: PlutoColumnType.number(),
          width: 50),
    ]);
  }

  List<PlutoRow> getRows() {
    return lists
        .map(
          (e) => PlutoRow(
            cells: {
              "nomina": PlutoCell(
                  value: "${e.estudiante!.nombre} ${e.estudiante!.apellido}"),
              "leccion1": PlutoCell(
                value: e
                    .getPrimerTrimestre()
                    .getCalificacion(1, 1, 1)
                    .calificacion,
              ),
              "leccion2": PlutoCell(
                value: e
                    .getPrimerTrimestre()
                    .getCalificacion(1, 1, 2)
                    .calificacion,
              ),
              "leccion3": PlutoCell(
                value: e
                    .getPrimerTrimestre()
                    .getCalificacion(1, 1, 3)
                    .calificacion,
              ),
              "leccion_cualitativo": PlutoCell(
                value: e
                            .getPrimerTrimestre()
                            .getCalificacion(1, 1, 4)
                            .calificacion ==
                        3
                    ? "A"
                    : e
                                .getPrimerTrimestre()
                                .getCalificacion(1, 1, 4)
                                .calificacion ==
                            2
                        ? "EP"
                        : e
                                    .getPrimerTrimestre()
                                    .getCalificacion(1, 1, 4)
                                    .calificacion ==
                                1
                            ? "I"
                            : "NE",
              ),
              "prueba1": PlutoCell(
                value: e
                    .getPrimerTrimestre()
                    .getCalificacion(1, 2, 1)
                    .calificacion,
              ),
              "prueba2": PlutoCell(
                value: e
                    .getPrimerTrimestre()
                    .getCalificacion(1, 2, 2)
                    .calificacion,
              ),
              "prueba3": PlutoCell(
                value: e
                    .getPrimerTrimestre()
                    .getCalificacion(1, 2, 3)
                    .calificacion,
              ),
              "prueba_cualitativo": PlutoCell(
                value: e
                            .getPrimerTrimestre()
                            .getCalificacion(1, 2, 4)
                            .calificacion ==
                        1
                    ? "I"
                    : e
                                .getPrimerTrimestre()
                                .getCalificacion(1, 2, 4)
                                .calificacion ==
                            2
                        ? "EP"
                        : e
                                    .getPrimerTrimestre()
                                    .getCalificacion(1, 2, 4)
                                    .calificacion ==
                                3
                            ? "A"
                            : "NE",
              ),
              "tarea1": PlutoCell(
                value: e
                    .getPrimerTrimestre()
                    .getCalificacion(1, 3, 1)
                    .calificacion,
              ),
              "tarea2": PlutoCell(
                value: e
                    .getPrimerTrimestre()
                    .getCalificacion(1, 3, 2)
                    .calificacion,
              ),
              "tarea3": PlutoCell(
                value: e
                    .getPrimerTrimestre()
                    .getCalificacion(1, 3, 3)
                    .calificacion,
              ),
              "tarea_cualitativo": PlutoCell(
                value: e
                            .getPrimerTrimestre()
                            .getCalificacion(1, 3, 4)
                            .calificacion ==
                        3
                    ? "A"
                    : e
                                .getPrimerTrimestre()
                                .getCalificacion(1, 3, 4)
                                .calificacion ==
                            2
                        ? "EP"
                        : e
                                    .getPrimerTrimestre()
                                    .getCalificacion(1, 3, 4)
                                    .calificacion ==
                                1
                            ? "I"
                            : "NE",
              ),
              "proyecto1": PlutoCell(
                  value: e
                      .getPrimerTrimestre()
                      .getCalificacion(2, 4, 1)
                      .calificacion),
              "proyecto2": PlutoCell(
                  value: e
                      .getPrimerTrimestre()
                      .getCalificacion(2, 4, 2)
                      .calificacion),
              "proyecto3": PlutoCell(
                  value: e
                      .getPrimerTrimestre()
                      .getCalificacion(2, 4, 3)
                      .calificacion),
              "proyecto_cualitativo": PlutoCell(
                  value: e
                              .getPrimerTrimestre()
                              .getCalificacion(2, 4, 4)
                              .calificacion ==
                          3
                      ? "A"
                      : e
                                  .getPrimerTrimestre()
                                  .getCalificacion(2, 4, 4)
                                  .calificacion ==
                              2
                          ? "EP"
                          : e
                                      .getPrimerTrimestre()
                                      .getCalificacion(2, 4, 4)
                                      .calificacion ==
                                  1
                              ? "I"
                              : "NE"),
              "exposicion1": PlutoCell(
                  value: e
                      .getPrimerTrimestre()
                      .getCalificacion(2, 5, 1)
                      .calificacion),
              "exposicion2": PlutoCell(
                  value: e
                      .getPrimerTrimestre()
                      .getCalificacion(2, 5, 2)
                      .calificacion),
              "exposicion3": PlutoCell(
                  value: e
                      .getPrimerTrimestre()
                      .getCalificacion(2, 5, 3)
                      .calificacion),
              "exposicion_cualitativo": PlutoCell(
                  value: e
                      .getPrimerTrimestre()
                      .getCalificacion(2, 5, 4)
                      .calificacion),
              "taller1": PlutoCell(
                  value: e
                      .getPrimerTrimestre()
                      .getCalificacion(2, 6, 1)
                      .calificacion),
              "taller2": PlutoCell(
                  value: e
                      .getPrimerTrimestre()
                      .getCalificacion(2, 6, 2)
                      .calificacion),
              "taller3": PlutoCell(
                  value: e
                      .getPrimerTrimestre()
                      .getCalificacion(2, 6, 3)
                      .calificacion),
              "taller_cualitativo": PlutoCell(
                  value: e
                      .getPrimerTrimestre()
                      .getCalificacion(2, 6, 4)
                      .calificacion),
              "aporte_cualitativo": PlutoCell(
                  value: e.getPrimerTrimestre().aporteCualitativo ?? 0),
              "proyecto_integrador": PlutoCell(
                  value: e.getPrimerTrimestre().proyectoIntegrador ?? 0),
              "cualitativo_proyecto_integrador": PlutoCell(
                  value: e.getPrimerTrimestre().cualitativoProyectoIntegrador ??
                      0),
            },
          ),
        )
        .toList();
  }
}
