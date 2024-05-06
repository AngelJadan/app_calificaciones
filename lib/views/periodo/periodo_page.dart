import 'package:app_calificaciones/controller/periodo_controller.dart';
import 'package:app_calificaciones/router/router.dart';
import 'package:app_calificaciones/utils/drawer.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PeriodoPage extends StatelessWidget {
  const PeriodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PeriodoController(),
      builder: (controller) => Center(
        child: Scaffold(
          appBar: AppBar(
            title: IconButton(
              onPressed: () => Get.offAllNamed(Routers.HOME),
              icon: const SizedBox(
                width: 50,
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios),
                    Icon(
                      Icons.home,
                    )
                  ],
                ),
              ),
              tooltip: "Inicio",
            ),
          ),
          drawer: getDrawer(Get.context!),
          body: Center(
            child: controller.obx(
              (state) => Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Color del borde gris
                      width: 2, // Ancho del borde
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: DataTable2(
                  showCheckboxColumn: false,
                  scrollController: ScrollController(),
                  columns: const [
                    DataColumn(
                      label: Text(
                        "Periodo",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Estado",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Inicio de periodo",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Cierre de periodo",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: controller.lists
                      .map(
                        (e) => DataRow(
                          onSelectChanged: (value) {},
                          cells: controller.getDataRow(e),
                        ),
                      )
                      .toList(),
                ),
              ),
              onEmpty: const Text("Sin datos"),
              onError: (error) => Text("Error: $error"),
              onLoading: const CircularProgressIndicator(),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.viewEdit();
            },
            tooltip: "Crear nuevo periodo",
            child: const Column(
              children: [
                Icon(Icons.add),
                Text("Nuevo"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
