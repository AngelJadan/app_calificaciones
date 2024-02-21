import 'package:app_calificaciones/models/login_model.dart';
import 'package:app_calificaciones/router/router.dart';
import 'package:app_calificaciones/services/remote/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/local/authentication.dart';

class LoginController {
  RxBool loading = false.obs;
  LoginModel loginModel = LoginModel();
  SessionProvider sessionProvider = SessionProvider();
  AuthentificacionService authenticationService = AuthentificacionService();
  login(String email, String password) async {
    LoginModel res = await authenticationService.getToken(email, password);
    sessionProvider.login(res);
    Get.offAllNamed(Routers.HOME);
  }

  logout() async {}

  getPerson() async {
    loginModel = await sessionProvider.getSession();
  }
}
