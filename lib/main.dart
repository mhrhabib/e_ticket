import 'package:e_ticket/app/di.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await GetStorage.init();
  runApp(const MyApp());
}
