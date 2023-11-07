import 'package:csv/csv.dart';
import 'package:dictionary/models/data_model.dart';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

final Box<DictionaryModel> dictionaryBox =
    Hive.box<DictionaryModel>('dictionaryBox');
List<List<dynamic>> data = [];

Future<void> loadCsv() async {
  if (dictionaryBox.isEmpty) {
    final rawData = await rootBundle.loadString("assets/olam-enml.csv");
    // Box<DictionaryModel> dictionaryBox =
    //     Hive.box<DictionaryModel>("dictionaryBox");
    data = const CsvToListConverter().convert(rawData, fieldDelimiter: "\t");
    for (int i = 1; i < data.length; i++) {
      final value = DictionaryModel(
        englishWord: data[i][1].toString().toLowerCase(),
        partOfSpeech: data[i][2].toString().toLowerCase(),
        malayalamDefinition: data[i][3].toString().toLowerCase(),
      );
      await dictionaryBox.add(value);
    }
  } else {}
}
