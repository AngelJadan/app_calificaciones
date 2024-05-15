import 'package:app_calificaciones/controller/abstract_controller.dart';
import 'package:app_calificaciones/models/estudiante_model.dart';
import 'package:app_calificaciones/models/materia_curso_docente_model.dart';
import 'package:app_calificaciones/models/materia_curso_model.dart';
import 'package:app_calificaciones/services/remote/estudiante_service.dart';
import 'package:app_calificaciones/services/remote/materia_estudiante_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

class CursoEstudianteController extends AbstractController<
    MateriaEstudianteService, MateriaEstudianteModel> {
  CursoEstudianteController() : super(MateriaEstudianteModel.new);

  final serviceEstudiante = Get.find<EstudianteService>();
  MateriaCursoDocente? materiaCursoDocente;
  final args = Get.arguments;

  List<EstudianteModel> estudiantes = [];

  final List<PlutoColumn> columns = [];
  final List<PlutoColumnGroup> columnGroup = [];
  final List<PlutoRow> rows = [];

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
      final arguments = Get.arguments as Map<String, dynamic>;
      if (kDebugMode) {
        print("arguments: $arguments");
      }
      if (kDebugMode) {
        print("arguments $arguments");
      }

      materiaCursoDocente = arguments['curso'];
      if (kDebugMode) {
        print("curso: $materiaCursoDocente");
      }
      setObject(null);
      if (materiaCursoDocente != null) {
        await getEstudiantesCurso();
        await getAllEstudiantes();
      }
    }
    addPlutoGroup();
    change(lists, status: RxStatus.success());
  }

  getEstudiantesCurso() async {
    lists = await service.getMateriaEstudiante(materiaCursoDocente!.curso!);
  }

  getAllEstudiantes() async {
    estudiantes = await serviceEstudiante.getAll();
  }

  save(MateriaEstudianteModel object) async {
    var result = await service.create(object);
    if (kDebugMode) {
      print("result $result");
    }
  }

  addPlutoGroup() {
    columnGroup.addAll([
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
    ]);

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
        type: PlutoColumnType.text(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'leccion2',
        backgroundColor: backgroundLecciones,
        type: PlutoColumnType.text(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: '',
        field: 'leccion3',
        backgroundColor: backgroundLecciones,
        type: PlutoColumnType.text(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
          width: 50,
          title: 'CUALITATIVO',
          field: "leccion_cualitativo",
          backgroundColor: backgroundLecciones,
          type: PlutoColumnType.text()),

      ///
      ///
      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'prueba1',
        backgroundColor: backgroundPruebas,
        type: PlutoColumnType.text(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'prueba2',
        backgroundColor: backgroundPruebas,
        type: PlutoColumnType.text(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: '',
        field: 'prueba3',
        backgroundColor: backgroundPruebas,
        type: PlutoColumnType.text(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
          width: 50,
          title: 'CUALITATIVO',
          field: "prueba_cualitativo",
          backgroundColor: backgroundPruebas,
          type: PlutoColumnType.text()),

      ///

      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'tarea1',
        backgroundColor: backgroundTareas,
        type: PlutoColumnType.text(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'tarea2',
        backgroundColor: backgroundTareas,
        type: PlutoColumnType.text(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: '',
        field: 'tarea3',
        backgroundColor: backgroundTareas,
        type: PlutoColumnType.text(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
          width: 50,
          title: 'CUALITATIVO',
          field: "tarea_cualitativo",
          backgroundColor: backgroundTareas,
          type: PlutoColumnType.text()),
    ]);

    columns.addAll([
      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'proyecto1',
        backgroundColor: backgroundProyecto,
        type: PlutoColumnType.text(),
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
        type: PlutoColumnType.text(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
          width: 50,
          title: 'CUALITATIVO',
          field: "proyecto_cualitativo",
          backgroundColor: backgroundProyecto,
          type: PlutoColumnType.text()),

      ///
      ///
      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'exposicion1',
        backgroundColor: backgroundPruebas,
        type: PlutoColumnType.text(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'exposicion2',
        backgroundColor: backgroundPruebas,
        type: PlutoColumnType.text(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: '',
        field: 'exposicion3',
        backgroundColor: backgroundPruebas,
        type: PlutoColumnType.text(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
          width: 50,
          title: 'CUALITATIVO',
          field: "exposicion_cualitativo",
          backgroundColor: backgroundPruebas,
          type: PlutoColumnType.text()),

      ///

      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'taller1',
        backgroundColor: backgroundTareas,
        type: PlutoColumnType.text(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: 'LECCIÓN ESCRITA DE LAS PARTES ORACIÓN',
        field: 'taller2',
        backgroundColor: backgroundTareas,
        type: PlutoColumnType.text(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        width: 50,
        title: '',
        field: 'taller3',
        backgroundColor: backgroundTareas,
        type: PlutoColumnType.text(),
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
          width: 50,
          title: 'CUALITATIVO',
          field: "taller_cualitativo",
          backgroundColor: backgroundTareas,
          type: PlutoColumnType.text()),
    ]);
  }
}
