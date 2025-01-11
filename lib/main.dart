import 'package:e_ticket/app/di.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'app/app.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

void checkPrinterStatus() async {
  try {
    final status = await SunmiPrinterPlus().getStatus();
    debugPrint('Printer Status: $status');
  } catch (e) {
    debugPrint('Error checking printer status: $e');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await GetStorage.init();
  checkPrinterStatus();
  runApp(const MyApp());
}
