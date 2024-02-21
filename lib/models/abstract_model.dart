import 'package:flutter/material.dart';

abstract class AbstractModel<I> with ChangeNotifier {
  I? id;
  AbstractModel(this.id);
  Map<String, dynamic> toJson();
}
