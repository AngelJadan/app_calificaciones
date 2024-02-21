// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_calificaciones/controller/abstract_controller.dart';
import 'package:flutter/material.dart';

import 'package:app_calificaciones/models/curso_model.dart';
import 'package:app_calificaciones/services/remote/curso_service.dart';
import 'package:get/get.dart';

class CursoController extends AbstractController<CursoService, CursoModel> {
  List<CursoModel> cursos = [];
  final _cursoService = CursoService();
  RxBool loading = true.obs;

  CursoModel curso = CursoModel();
  List<Map> paralelos = [];

  String nivelSelected = "Basico";
  TextEditingController nombreCurso = TextEditingController();

  CursoController() : super(CursoModel.new);

  @override
  onInit() {
    super.onInit();
    init();
  }

  init() async {
    loading.value = true;
    await getCursos();
    await getParalelos();
    loading.value = false;
    update();
  }

  getCursos() async {
    cursos = await _cursoService.listCurso();
  }

  clean() async {
    loading.value = true;
    nombreCurso.clear();
    curso.nivel = "1";
    loading.value = false;
    await getParalelos();
  }

  getParalelos() async {
    paralelos = await _cursoService.listParalelos();
    curso.paralelo = paralelos.first;
  }

  set setCurso(CursoModel curso) {
    this.curso = curso;
  }

  void setNivel(String nivel) {
    nivelSelected = nivel;
    curso.nivel = nivel == "Basico" ? "1" : "2";
    update(["idNivelSelected"]);
  }

  void setParalelo(Map paralelo) {
    curso.paralelo = paralelo;
    update(["idParaleloSelected"]);
  }

  saveCurso() async {
    update();
    loading.value = true;
    curso.nombre = nombreCurso.text.toUpperCase();
    await _cursoService.create(curso);
    await getCursos();
    await getParalelos();
    loading.value = false;
    update();
  }

  deleteCurso(CursoModel curso) async {
    loading.value = true;
    await _cursoService.delete(curso);
    await init();
  }

  get getNivel => nivelSelected;
}
