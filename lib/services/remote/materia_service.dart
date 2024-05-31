import 'dart:convert';
import 'dart:io';

import 'package:app_calificaciones/models/login_model.dart';
import 'package:app_calificaciones/models/materia_model.dart';
import 'package:app_calificaciones/services/remote/abstract_service.dart';
import 'package:app_calificaciones/utils/connections.dart';
import 'package:http/http.dart' as http;

class MateriaService extends AbstractService<MateriaModel> {
  @override
  Future<MateriaModel> create(MateriaModel object) async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session!.token!, session.cookies as String);
    var request = http.Request('POST', Uri.parse(UrlAddress.materia));
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
  Future<MateriaModel> update(MateriaModel object) async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session!.token!, session.cookies as String);
    var request = http.Request('PUT', Uri.parse(UrlAddress.materia));
    request.body = json.encode(object);

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
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

  Future<bool> remove(MateriaModel object) async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session!.token!, session.cookies as String);
    var request = http.Request(
      'DELETE',
      Uri.parse("${UrlAddress.materia}?id=${object.id}"),
    );
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<MateriaModel>> getAll() async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session!.token!, session.cookies as String);
    var request = http.Request('GET', Uri.parse(UrlAddress.materiaList));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    //print('cookie: $cookie');
    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((e) => MateriaModel.fromMap(e))
          .toList()
          .cast<MateriaModel>();
    } else {
      try {
        throw Exception("usuario");
      } on SocketException catch (_) {
        rethrow;
      }
    }
  }

  Future<List<Map>> listArea() async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session!.token!, session.cookies as String);
    var request = http.Request('GET', Uri.parse(UrlAddress.listArea));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    //print('cookie: $cookie');
    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((e) => Map.from(e))
          .toList();
    } else {
      try {
        throw Exception("usuario");
      } on SocketException catch (_) {
        rethrow;
      }
    }
  }
}
