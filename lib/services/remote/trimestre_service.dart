import 'dart:convert';
import 'dart:io';

import 'package:app_calificaciones/models/calificacion_estudiante/trimestre_cabecera_model.dart';
import 'package:app_calificaciones/models/login_model.dart';
import 'package:app_calificaciones/services/remote/abstract_service.dart';
import 'package:app_calificaciones/utils/connections.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TrimestreService extends AbstractService<CabeceraTrimestreModel> {
  @override
  Future<CabeceraTrimestreModel> create(CabeceraTrimestreModel object) async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session.token!, session.cookies as String);
    var request =
        http.Request('POST', Uri.parse(UrlAddress.estudiante_trimestre));
    request.body = json.encode(removeId(object));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    //print('cookie: $cookie');
    debugPrint("response: ${response.body}");
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
  Future<CabeceraTrimestreModel> update(CabeceraTrimestreModel object) async {
    LoginModel? session = await localAuthRepository.getSession();
    var headers = UrlAddress.getHeadersWithToken(
        session.token!, session.cookies as String);
    var request =
        http.Request('PUT', Uri.parse(UrlAddress.estudiante_trimestre));
    request.body = json.encode(object);

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    debugPrint("response: ${response.body}");
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
}
