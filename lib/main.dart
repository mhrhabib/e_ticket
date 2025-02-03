import 'package:e_ticket/app/di.dart';
import 'package:e_ticket/core/common/helper/hive_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'app/app.dart';
import 'package:my_device_info/my_device_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await GetStorage.init();
  await HiveSetup.init();
  await getDeviceInfo();
  runApp(const MyApp());
}

Future<String?> getDeviceInfo() async {
  if (await Permission.phone.request().isGranted) {
    try {
      var imeiNo = await MyDeviceInfo.deviceIMEINumber;
      print("IMEI Number: $imeiNo");
      return imeiNo;
    } on PlatformException {
      print("Failed to get IMEI number.");
      return null;
    }
  }
  return null;
}
