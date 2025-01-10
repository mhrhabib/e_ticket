import 'package:hive_flutter/hive_flutter.dart';

import '../models/local_ticket_fare_model.dart';
import '../models/local_ticket_sale_model.dart';

class LocalDataService {
  Future<void> saveFareListLocally(List<LocalTicketFareModel> fares) async {
    final box = await Hive.openBox<LocalTicketFareModel>('ticket_fares');
    // Clear existing data before saving new fare list
    await box.clear();
    for (var fare in fares) {
      await box.add(fare);
    }
  }

  Future<List<LocalTicketFareModel>> getFareListLocally() async {
    final box = await Hive.openBox<LocalTicketFareModel>('ticket_fares');
    return box.values.toList();
  }

  Future<void> saveTicketSaleLocally(List<LocalTicketSaleModel> ticketSales) async {
    final box = await Hive.openBox<LocalTicketSaleModel>('ticket_sales');
    // Clear existing data before saving new ticket sales list
    await box.clear();
    for (var sale in ticketSales) {
      await box.add(sale);
    }
  }

  Future<List<LocalTicketSaleModel>> getTicketSalesLocally() async {
    final box = await Hive.openBox<LocalTicketSaleModel>('ticket_sales');
    return box.values.toList();
  }
}
