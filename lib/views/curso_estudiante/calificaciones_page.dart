import 'package:app_calificaciones/controller/curso_estudiante_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

Widget viewDataCalificaciones(
    CursoEstudianteController controller, BuildContext context) {
  double width = context.mediaQuery.size.width;
  double height = context.mediaQuery.size.height;

  return Align(
    alignment: Alignment.center,
    child: Container(
      margin: const EdgeInsets.all(10),
      width: width,
      child: SizedBox(
        width: width * 0.8,
        height: height * 0.9,
        child: controller.obx(
          (state) => PlutoGrid(
            columnGroups: controller.columnGroup,
            columns: controller.columns,
            rows: controller.rows,
            onChanged: (PlutoGridOnChangedEvent event) {
              if (kDebugMode) {
                print("event onchanged: $event");
              }
            },
            onLoaded: (PlutoGridOnLoadedEvent event) {
              if (kDebugMode) {
                print("event loaded: $event");
              }
            },
          ),
          onLoading: const CircularProgressIndicator(),
        ),
      ),
    ),
  );
}
