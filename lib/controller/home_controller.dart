// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_calificaciones/models/login_model.dart';
import 'package:app_calificaciones/services/local/authentication.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  SessionProvider sessionProvider = SessionProvider();

  LoginModel loginModel = LoginModel();
  RxBool loading = true.obs;

  @override
  onInit() {
    super.onInit();
    init();
  }

  init() async {
    await getSession();
    loading.value = false;
    update(['home']);
  }

  getSession() async {
    if (kDebugMode) {
      print("inicio get session");
    }
    sessionProvider.getSession();
    loginModel = await sessionProvider.getSession();

    loading.value = false;
    update();
    if (kDebugMode) {
      print("inicio session");
    }
  }
}
