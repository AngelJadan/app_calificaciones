import 'dart:convert';
import 'dart:io';

import 'package:app_calificaciones/models/estudiante_model.dart';
import 'package:app_calificaciones/services/remote/abstract_service.dart';
import 'package:app_calificaciones/utils/connections.dart';

import '../../models/login_model.dart';
import 'package:http/http.dart' as http;

class EstudianteService extends AbstractService<EstudianteModel> {
  @override
  Future<EstudianteModel> create(EstudianteModel object) async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session.token!, session.cookies as String);
    var request = http.Request('POST', Uri.parse(UrlAddress.estudiante));
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
  Future<bool> update(EstudianteModel object) async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session.token!, session.cookies as String);
    var request = http.Request('PUT', Uri.parse(UrlAddress.estudiante));
    request.body = json.encode(object.toJson());

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
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

  @override
  Future<bool> delete(EstudianteModel object) async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session.token!, session.cookies as String);
    var request = http.Request(
        'DELETE', Uri.parse("${UrlAddress.estudiante}?id=${object.id}"));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

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

  @override
  Future<List<EstudianteModel>> getAll() async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session.token!, session.cookies as String);
    var request = http.Request('GET', Uri.parse(UrlAddress.list_estudiante));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((e) => EstudianteModel.fromMap(e))
          .toList()
          .cast<EstudianteModel>();
    } else {
      try {
        throw Exception("usuario");
      } on SocketException catch (_) {
        rethrow;
      }
    }
  }
}
