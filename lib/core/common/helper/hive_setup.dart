import 'package:hive_flutter/hive_flutter.dart';
import '../../../modules/tickets/data/models/local_ticket_fare_model.dart';
import '../../../modules/tickets/data/models/local_ticket_sale_model.dart';

class HiveSetup {
  static Future<void> init() async {
    // Initialize Hive
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(LocalTicketSaleModelAdapter());
    Hive.registerAdapter(LocalTicketFareModelAdapter());

    // Open boxes
    await Hive.openBox<LocalTicketSaleModel>('ticket_sales');
    await Hive.openBox<LocalTicketFareModel>('ticket_fares');
  }
}
