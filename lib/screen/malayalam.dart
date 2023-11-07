import 'package:dictionary/controller/searchcontroller.dart';
import 'package:dictionary/screen/english.dart';
import 'package:dictionary/screen/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class malayalamScreen extends StatelessWidget {
  const malayalamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: homeScreen(
        color: Colors.black,
        appBarText: 'മലയാളം -> English ...',
        textField: 'മലയാളത്തിൽ ടൈപ്പ് ചെയ്യുക',
        pageRoute: () {
          Get.off(
            () => const EnglishScreen(),
          );
          dictionaryList.clear();
          userInput.value = '';
          dictionaryDataMap.clear();
        },
        listData: malayalamWordsList,
      ),
    );
  }
}
