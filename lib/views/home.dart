import 'package:app_calificaciones/controller/home_controller.dart';
import 'package:app_calificaciones/utils/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.mediaQuery.size.width;
    final height = context.mediaQuery.size.width;
    return GetBuilder(
      init: HomeController(),
      builder: (controller) => controller.loading.value
          ? MaterialApp(
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                return const SizedBox(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            )
          : Scaffold(
              appBar: AppBar(
                title: const Text(""),
              ),
              drawer: getDrawer(Get.context!),
              body: Container(
                margin: const EdgeInsets.all(20),
                width: width,
                height: height,
                child: Center(
                  child: getMenuGridHome(context),
                ),
              ),
            ),
    );
  }
}
