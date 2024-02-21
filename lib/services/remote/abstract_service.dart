// ignore_for_file: override_on_non_overriding_member

import 'package:app_calificaciones/models/abstract_model.dart';
import 'package:app_calificaciones/services/local/authentication.dart';

abstract class AbstractService<T extends AbstractModel> {
  SessionProvider localAuthRepository = SessionProvider();
  Map<String, dynamic> removeId(T object) {
    var obj = object.toJson();
    obj.remove("id");
    return obj;
  }

  @override
  Future<T> create(T object) async {
    throw UnimplementedError();
  }

  Future<dynamic> update(T object) async {
    throw UnimplementedError();
  }

  Future<List<T>?> getAll() async {
    throw UnimplementedError();
  }

  Future<T> read(dynamic id) {
    throw UnimplementedError();
  }

  Future<dynamic> delete(T object) {
    throw UnimplementedError();
  }
}
