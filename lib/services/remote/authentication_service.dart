import 'dart:convert';
import 'dart:io';

import 'package:app_calificaciones/models/login_model.dart';
import 'package:app_calificaciones/services/remote/abstract_service.dart';
import 'package:app_calificaciones/utils/connections.dart';
import 'package:http/http.dart' as http;

class AuthentificacionService extends AbstractService<LoginModel> {
  Future<LoginModel> getToken(String email, String password) async {
    var headers = UrlAddress.headers;
    var request = http.Request('POST', Uri.parse(UrlAddress.login));
    request.body = json.encode({"email": email, "password": password});
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      LoginModel object =
          LoginModel.fromMap(jsonDecode(utf8.decode(response.bodyBytes)));
      return object;
    } else {
      try {
        throw Exception(jsonDecode(utf8.decode(response.bodyBytes)));
      } on SocketException catch (_) {
        rethrow;
      }
    }
  }

  Future<bool> logout() async {
    var headers = UrlAddress.headers;
    var request = http.Request('POST', Uri.parse(UrlAddress.login));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return true;
    } else {
      try {
        throw Exception(jsonDecode(utf8.decode(response.bodyBytes)));
      } on SocketException catch (_) {
        rethrow;
      }
    }
  }
}
