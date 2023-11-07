import 'package:dictionary/controller/searchcontroller.dart';
import 'package:dictionary/screen/homeScreen.dart';
import 'package:dictionary/screen/malayalam.dart';
import 'package:dictionary/widget/history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnglishScreen extends StatelessWidget {
  const EnglishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: homeScreen(
        color: Colors.blue,
        appBarText: 'English -> മലയാളം ...',
        textField: 'type english word',
        pageRoute: () {
          Get.off(() => const malayalamScreen());
          dictionaryList.clear();
          dictionaryDataMap.clear();
          userInput.value = '';
        },
        listData: englishWordsList,
      ),
    );
  }
}
