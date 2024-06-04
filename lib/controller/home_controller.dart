// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_calificaciones/models/login_model.dart';
import 'package:app_calificaciones/services/local/authentication.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../router/router.dart';

class HomeController extends GetxController {
  SessionProvider sessionProvider = SessionProvider();

  LoginModel? loginModel;
  RxBool loading = true.obs;

  @override
  onInit() {
    super.onInit();
    init();
  }

  init() async {
    await getSession();
    if (loginModel == null) {
      debugPrint("loginModel is null");
      //Get.offAllNamed(Routers.LOGIN);
      Navigator.pushNamed(Get.context!, Routers.LOGIN);
    }
    update(['home']);

    loading.value = false;
  }

  getSession() async {
    sessionProvider.getSession();
    loginModel = await sessionProvider.getSession();
    loading.value = false;
    update();
  }
}
