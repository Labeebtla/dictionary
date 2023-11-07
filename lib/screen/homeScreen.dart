// ignore_for_file: camel_case_types

import 'package:dictionary/controller/searchcontroller.dart';

import 'package:dictionary/widget/definition.dart';
import 'package:dictionary/widget/history.dart';
import 'package:dictionary/widget/radiobutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class homeScreen extends StatelessWidget {
  final Color color;

  final String appBarText;

  final String textField;
  final VoidCallback pageRoute;

  final Function listData;

  const homeScreen({
    super.key,
    required this.color,
    required this.appBarText,
    required this.textField,
    required this.pageRoute,
    required this.listData,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController searchItemController = (TextEditingController());

    userInput.value = '';
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Center(
                child: Text(
                  'dictionary',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 20, color: color, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: AppBar(
            backgroundColor: color,
            title: Text(appBarText),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: color == Colors.blue ? () {} : pageRoute,
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(180, 50),
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          'ENG-> മലയാളം',
                          style: TextStyle(color: Colors.black),
                        )),
                    ElevatedButton(
                        onPressed: color == Colors.black ? () {} : pageRoute,
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(180, 50),
                          backgroundColor: Colors.grey[400],
                        ),
                        child: const Text(
                          ' മലയാളം ->ENG',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                )),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: 'share',
                  );
                },
                icon: const Icon(Icons.share),
                color: Colors.yellow,
              ),
            ],
          )),
      body: Column(children: [
        Expanded(
          child: Obx(() => ListView.builder(
              itemCount: dictionaryDataMap.length,
              itemBuilder: (context, index) {
                final listData = dictionaryDataMap.keys.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    definitionPage(listData, color);
                  },
                  child: Card(
                    margin: const EdgeInsets.all(4),
                    elevation: 1,
                    child: ListTile(
                      title: Text(listData),
                    ),
                  ),
                );
              })),
        ),
        Container(
            height: 80.0,
            color: color,
            child: Obx(
              () => Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          historyPage(color);
                        },
                        icon: const Icon(
                          Icons.history,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                            RegExp('^'),
                          )
                        ],
                        controller: searchItemController,
                        onChanged: (value) {
                          userInput.value = value;
                          listData();
                        },
                        decoration: InputDecoration(
                          hintText: textField,
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    userInput.isEmpty
                        ? Expanded(
                            child: IconButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: 'Really?',
                                  middleText: 'Just Type Manh',
                                  textCancel: 'Okay',
                                );
                              },
                              icon: const Icon(
                                Icons.mic_none,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Expanded(
                            child: IconButton(
                              onPressed: () {
                                dictionaryList.clear();
                                dictionaryDataMap.clear();
                                searchItemController.clear();
                                userInput.value = '';
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                          ),
                    Visibility(
                      visible: userInput.isEmpty ? false : true,
                      child: Expanded(
                        child: IconButton(
                          onPressed: () {
                            definitionPage(
                                dictionaryList.first.englishWord, color);
                          },
                          icon: const Icon(
                            Icons.check_box_outlined,
                            color: Colors.lightGreen,
                          ),
                        ),
                      ),
                    )
                  ]),
            )),
        Row(children: [
          Flexible(
              child: RadioButton(
            radioButtonText: 'startwith',
            value: RadioValue.startWith,
            color: color,
          )),
          Expanded(
              child: RadioButton(
            radioButtonText: 'contains',
            value: RadioValue.contains,
            color: color,
          )),
          Expanded(
              child: RadioButton(
            radioButtonText: 'endswith',
            value: RadioValue.endsWith,
            color: color,
          )),
        ]),
      ]),
    );
  }
}
