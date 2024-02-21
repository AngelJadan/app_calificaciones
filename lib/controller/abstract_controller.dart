import 'package:app_calificaciones/models/abstract_model.dart';
import 'package:app_calificaciones/services/remote/abstract_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AbstractController<S extends AbstractService,
    T extends AbstractModel> extends GetxController with StateMixin<List<T>> {
  List<T> lists = [];
  late Rx<T> object;
  var formKeyCliente = GlobalKey<FormState>();
  final T Function() creator;
  S service = Get.find<S>();
  AbstractController(this.creator);
  init() async {
    try {
      change(null, status: RxStatus.loading());

      lists.isEmpty
          ? change([], status: RxStatus.empty())
          : change(lists, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  setObject(dynamic id) {
    object = id != null && id > 0
        ? lists.elementAt(lists.indexWhere((element) => element.id == id)).obs
        : creator().obs;
  }
}
