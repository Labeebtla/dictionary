import 'package:dictionary/widget/definition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var enghistoryMap = {}.obs;
var malhistoryMap = {}.obs;
historyPage(Color color) {
  Get.dialog(
    Padding(
      padding: const EdgeInsets.all(15.0),
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
              'History',
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    color == Colors.blue ? enghistoryMap : malhistoryMap;
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ))
            ]),
        body: Obx(
          () => ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  definitionPage(
                      color == Colors.blue
                          ? enghistoryMap.keys.elementAt(index)
                          : malhistoryMap.keys.elementAt(index),
                      color);
                  // print(historyMap.keys.elementAt(index));
                },
                child: Card(
                  color: Colors.grey,
                  child: ListTile(
                    title: Text(
                      color == Colors.blue
                          ? enghistoryMap.keys.elementAt(index)
                          : malhistoryMap.keys.elementAt(index),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
            itemCount: color == Colors.blue
                ? enghistoryMap.length
                : malhistoryMap.length,
          ),
        ),
      ),
    ),
  );
}
