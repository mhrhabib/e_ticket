import 'package:e_ticket/modules/tickets/data/models/sale_model.dart';
import 'package:e_ticket/modules/tickets/data/models/ticket_fare_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveSetup {
  static Future<void> init() async {
    // Initialize Hive
    await Hive.initFlutter();

    Hive.registerAdapter(TicketFareModelAdapter());
    Hive.registerAdapter(PricesAdapter()); // Register the Prices adapter
    Hive.registerAdapter(SaleModelAdapter()); // Register the adapter

    // Open the box globally during initialization

    if (!Hive.isBoxOpen('sales')) {
      print("Opening sales...");
      await Hive.openBox<SaleModel>('sales');
    }
    if (!Hive.isBoxOpen('fareBox')) {
      print("Opening fareBox...");
      await Hive.openBox<TicketFareModel>('fareBox');
    } else {
      print("fareBox is already open.");
    }
  }
}
