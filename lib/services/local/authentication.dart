import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/login_model.dart';

class SessionProvider {
  LoginModel _user = LoginModel();

  Future<LoginModel> getUser() async {
    await getSession();
    return _user;
  }

  Future<void> login(LoginModel user) async {
    _user = user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      "session",
      jsonEncode(_user.toJson()),
    );
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('session');
  }

  // Método para cargar el estado de la sesión al iniciar la aplicación
  Future<LoginModel> getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString("session") ?? '';
    print("data $data");
    return LoginModel.fromMap(jsonDecode(data));
  }
}
