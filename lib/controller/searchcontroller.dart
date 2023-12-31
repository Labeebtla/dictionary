import 'package:dictionary/widget/radiobutton.dart';

import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:dictionary/models/data_model.dart';

final Box<DictionaryModel> dictionaryBox = Hive.box('dictionaryBox');

var dictionaryList = <DictionaryModel>[].obs;
Rx<RadioValue> selectedRadioValue = RadioValue.contains.obs;
var userInput = ''.obs;
var dictionaryDataMap = <String, List<dynamic>>{}.obs;

// fetching the data from hive
// sorting with regex
// adding to the list and showing to the use
void englishWordsList() {
  RegExp regEx;
  switch (selectedRadioValue.value) {
    case RadioValue.startWith:
      regEx = RegExp('^${userInput.value}');
      break;
    case RadioValue.endsWith:
      regEx = RegExp('${userInput.value}\$');
      break;
    default:
      regEx = RegExp(userInput.value);
  }

  dictionaryList.clear();
  dictionaryDataMap.clear();

  var result = dictionaryBox.values
      .where(
        (element) => element.englishWord.toLowerCase().contains(regEx),
      )
      .toList();
  dictionaryList.value = result;
  var dictionaryKeys = dictionaryDataMap.keys.toSet();
  for (var element in dictionaryList) {
    if (dictionaryKeys.contains(element.englishWord)) {
      dictionaryDataMap[element.englishWord]?.add({
        'type': element.partOfSpeech,
        'meaning': element.malayalamDefinition
      });
    } else {
      dictionaryDataMap[element.englishWord] = [
        {'type': element.partOfSpeech, 'meaning': element.malayalamDefinition}
      ];
    }
  }
}

void malayalamWordsList() {
  RegExp regEx;
  switch (selectedRadioValue.value) {
    case RadioValue.startWith:
      regEx = RegExp('^${userInput.value}');
      break;
    case RadioValue.endsWith:
      regEx = RegExp('${userInput.value}\$');
      break;
    default:
      regEx = RegExp(userInput.value);
  }
  dictionaryList.clear();
  dictionaryDataMap.clear();

  var result = dictionaryBox.values
      .where(
        (element) => element.malayalamDefinition.contains(regEx),
      )
      .toList();
  dictionaryList.value = result;
  if (userInput.value == '') {
    dictionaryList.clear();
    dictionaryDataMap.clear();
  }

  var dictionaryKeys = dictionaryDataMap.keys.toSet();
  for (var element in dictionaryList) {
    if (dictionaryKeys.contains(element.malayalamDefinition)) {
      dictionaryDataMap[element.malayalamDefinition]?.add({
        'type': element.partOfSpeech,
        'meaning': element.englishWord,
      });
    } else {
      dictionaryDataMap[element.malayalamDefinition] = [
        {
          'type': element.partOfSpeech,
          'meaning': element.englishWord,
        }
      ];
    }
  }
}
