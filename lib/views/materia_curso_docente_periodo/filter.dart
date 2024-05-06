import 'package:flutter/material.dart';
import 'package:get/get.dart';

RxBool texto = false.obs;
filter() {
  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return ["1", "2"].map((String option) {
              return PopupMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList();
          },
          onSelected: (String value) {},
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text('Selecciona una opción'),
          ),
        ),
      ),
    ],
  );
}
