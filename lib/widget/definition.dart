import 'package:dictionary/controller/searchcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dictionary/models/data_model.dart';
import 'package:dictionary/widget/history.dart';

final Box<DictionaryModel> dictionaryBox = Hive.box('dictionaryBox');

void definitionPage(var id, Color color) async {
  // ignore: prefer_typing_uninitialized_variables
  var data;
  if (dictionaryDataMap.containsKey(id)) {
    data = dictionaryDataMap[id];
    print(id);
  }
  if (color == Colors.blue) {
    if (enghistoryMap.keys.contains(id)) {
    } else {
      enghistoryMap[id] = data;
    }
  } else {
    if (malhistoryMap.keys.contains(id)) {
    } else {
      malhistoryMap[id] = data;
    }
    // if (color == Colors.blue
    //     ? enghistoryMap.keys.contains(id)
    //     : malhistoryMap.keys.contains(id)) {
    // } else {
    //   color == Colors.blue ? enghistoryMap[id] : malhistoryMap[id] = data;
    // }
    print(enghistoryMap);
    print(malhistoryMap);
    await Get.dialog(Padding(
      padding: const EdgeInsets.all(20),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '$id meaning',
            softWrap: true,
          ),
        ),
        body: Column(children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        String partOfSpeechText = data[index]['type'];
                        switch (partOfSpeechText) {
                          case 'n':
                            partOfSpeechText = 'noun';
                            break;
                          case 'phr':
                            partOfSpeechText = 'phrase';
                            break;
                          case 'idm':
                            partOfSpeechText = 'idiom';
                            break;
                          case 'a':
                            partOfSpeechText = 'Adjective';
                            break;
                          case 'v':
                            partOfSpeechText = 'verb';
                            break;
                        }
                        return Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text('${data[index]['meaning']}'),
                              ),
                              Expanded(child: Text('($partOfSpeechText)'))
                            ],
                          ),
                        );
                      })))
        ]),
      ),
    ));
  }
}
