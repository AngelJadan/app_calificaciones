import 'dart:convert';
import 'dart:io';

import 'package:app_calificaciones/models/curso_model.dart';
import 'package:app_calificaciones/models/login_model.dart';
import 'package:app_calificaciones/services/remote/abstract_service.dart';
import 'package:app_calificaciones/utils/connections.dart';
import 'package:http/http.dart' as http;

class CursoService extends AbstractService<CursoModel> {
  @override
  Future<CursoModel> create(CursoModel object) async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session.token!, session.cookies as String);
    var request = http.Request('POST', Uri.parse(UrlAddress.curso));
    request.body = json.encode(removeId(object));

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
        throw Exception("usuario");
      } on SocketException catch (_) {
        rethrow;
      }
    }
    return object;
  }

  Future<List<CursoModel>> listCurso() async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session.token!, session.cookies as String);
    var request = http.Request('GET', Uri.parse(UrlAddress.list_all_cursos));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    //print('cookie: $cookie');
    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes))['results'] as List)
          .map((e) => CursoModel.fromMap(e))
          .toList()
          .cast<CursoModel>();
    } else {
      try {
        throw Exception("usuario");
      } on SocketException catch (_) {
        rethrow;
      }
    }
  }

  Future<List<Map>> listParalelos() async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session.token!, session.cookies as String);
    var request = http.Request('GET', Uri.parse(UrlAddress.list_paralelos));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    //print('cookie: $cookie');
    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes))['results'] as List)
          .map((e) => Map.from(e))
          .toList()
          .cast<Map>();
    } else {
      try {
        throw Exception(utf8.decode(response.bodyBytes));
      } on SocketException catch (_) {
        rethrow;
      }
    }
  }

  @override
  Future<bool> delete(CursoModel object) async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session.token!, session.cookies as String);
    var request = http.Request(
        'DELETE', Uri.parse("${UrlAddress.curso}?id=${object.id}"));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    //print('cookie: $cookie');
    if (response.statusCode == 200) {
      return true;
    } else {
      try {
        throw Exception("usuario");
      } on SocketException catch (_) {
        rethrow;
      }
    }
  }
}
