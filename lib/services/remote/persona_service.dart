import 'dart:convert';
import 'dart:io';

import 'package:app_calificaciones/models/login_model.dart';
import 'package:app_calificaciones/models/persona_model.dart';

import '../../utils/connections.dart';
import 'abstract_service.dart';
import 'package:http/http.dart' as http;

class PersonaService extends AbstractService<PersonaModel> {
  @override
  Future<PersonaModel> create(PersonaModel object) async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session!.token!, session.cookies as String);
    var request = http.Request('POST', Uri.parse(UrlAddress.funcionario));
    request.body = json.encode(removeId(object));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    //print('cookie: $cookie');
    if (response.statusCode == 201) {
      var resul = jsonDecode(utf8.decode(response.bodyBytes));
      var id = resul["id"];
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
  Future<PersonaModel> update(PersonaModel object) async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session!.token!, session.cookies as String);
    var request = http.Request('PUT', Uri.parse(UrlAddress.funcionario));
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

  Future<bool> remove(PersonaModel object) async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session!.token!, session.cookies as String);
    var request = http.Request(
      'DELETE',
      Uri.parse("${UrlAddress.funcionario}?id=${object.id}"),
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
  Future<List<PersonaModel>> getAll() async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session!.token!, session.cookies as String);
    var request = http.Request('GET', Uri.parse(UrlAddress.list_funcionario));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    //print('cookie: $cookie');
    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((e) => PersonaModel.fromMap(e))
          .toList()
          .cast<PersonaModel>();
    } else {
      try {
        throw Exception("usuario");
      } on SocketException catch (_) {
        rethrow;
      }
    }
  }
}
