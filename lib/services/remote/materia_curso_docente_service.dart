import 'dart:convert';
import 'dart:io';

import 'package:app_calificaciones/models/login_model.dart';
import 'package:app_calificaciones/models/materia_curso_docente_model.dart';
import 'package:app_calificaciones/models/periodo_model.dart';
import 'package:app_calificaciones/services/remote/abstract_service.dart';
import 'package:app_calificaciones/utils/connections.dart';
import 'package:http/http.dart' as http;

class MateriaCursoDocenteService extends AbstractService<MateriaCursoDocente> {
  @override
  Future<MateriaCursoDocente> create(MateriaCursoDocente object) async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session.token!, session.cookies as String);
    var request = http.Request(
        'POST', Uri.parse(UrlAddress.materia_curso_docente_periodo));
    request.body = json.encode(removeId(object));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    //print('cookie: $cookie');
    if (response.statusCode == 201) {
      var resul = jsonDecode(utf8.decode(response.bodyBytes));
      var id = resul["id"];
      //print(response.headers);
      object.id = id;
    } else {
      try {
        throw Exception(utf8.decode(response.bodyBytes));
      } on SocketException catch (_) {
        rethrow;
      }
    }
    return object;
  }

  @override
  Future<MateriaCursoDocente> update(MateriaCursoDocente object) async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session.token!, session.cookies as String);
    var request = http.Request(
        'PUT', Uri.parse(UrlAddress.materia_curso_docente_periodo));
    request.body = json.encode(object);

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    //print('cookie: $cookie');
    if (response.statusCode == 200) {
      var resul = jsonDecode(utf8.decode(response.bodyBytes));
      var id = resul["id"];
      //print(response.headers);
      object.id = id;
    } else {
      try {
        throw Exception(utf8.decode(response.bodyBytes));
      } on SocketException catch (_) {
        rethrow;
      }
    }
    return object;
  }

  @override
  Future<bool> delete(MateriaCursoDocente object) async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session.token!, session.cookies as String);
    var request = http.Request(
        'DELETE',
        Uri.parse(
            "${UrlAddress.materia_curso_docente_periodo}?id=${object.id}"));
    request.body = json.encode(object);

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    //print('cookie: $cookie');
    if (response.statusCode == 200) {
      return true;
    } else {
      try {
        throw Exception(utf8.decode(response.bodyBytes));
      } on SocketException catch (_) {
        rethrow;
      }
    }
  }

  Future<List<MateriaCursoDocente>> allList() async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session.token!, session.cookies as String);
    var request = http.Request(
        'GET', Uri.parse(UrlAddress.list_materia_curso_docente_periodo));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes))['results'] as List)
          .map((e) => MateriaCursoDocente.froMap(e))
          .toList()
          .cast<MateriaCursoDocente>();
    } else {
      try {
        throw Exception(utf8.decode(response.bodyBytes));
      } on SocketException catch (_) {
        rethrow;
      }
    }
  }

  Future<List<MateriaCursoDocente>> listCursoToPeriodo(
      PeriodoModel periodo) async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session.token!, session.cookies as String);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${UrlAddress.list_materia_curso_docente_to_periodo}${periodo.id}/"));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((e) => MateriaCursoDocente.froMap(e))
          .toList()
          .cast<MateriaCursoDocente>();
    } else {
      try {
        throw Exception(utf8.decode(response.bodyBytes));
      } on SocketException catch (_) {
        rethrow;
      }
    }
  }
}
