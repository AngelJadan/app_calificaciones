import 'package:app_calificaciones/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../utils/styles.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();

    final correoForm = TextFormField(
      decoration: const InputDecoration(
        label: Text(
          "Correo",
          style: TextStyle(color: Colors.white),
        ),
      ),
      onChanged: (value) => loginController.loginModel.correo = value,
    );
    final passwordForm = TextFormField(
      decoration: const InputDecoration(
        label: Text(
          "Contraseña",
          style: TextStyle(color: Colors.white),
        ),
      ),
      onChanged: (value) => loginController.loginModel.password = value,
    );
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColorHome(),
      appBar: AppBar(
        backgroundColor: backgroundColorHome(),
        title: const Center(
          child: Text(
            "Iniciar sesión",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: SizedBox(
            width: width < 500 ? width * 0.9 : 400,
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  correoForm,
                  passwordForm,
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () async {
                        //if (loginProvider.loginModel.isLogin) {
                        //  print("Session iniciada");
                        //} else {
                        await loginController.login(
                            loginController.loginModel.correo!,
                            loginController.loginModel.password!);
                      },
                      child: const Text(
                        "Ingresar",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
