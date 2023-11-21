import 'package:dictionary/functions/db_function.dart';
import 'package:dictionary/models/data_model.dart';
import 'package:dictionary/screen/english.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(DictionaryModelAdapter().typeId)) {
    Hive.registerAdapter(DictionaryModelAdapter());
  }
  await Hive.openBox<DictionaryModel>("dictionaryBox");

  loadCsv();

  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: EnglishScreen(),
  ));
}
