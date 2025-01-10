import 'package:hive/hive.dart';

part 'local_ticket_sale_model.g.dart';

@HiveType(typeId: 0) // Each model needs a unique typeId
class LocalTicketSaleModel {
  @HiveField(0)
  final String offid;

  @HiveField(1)
  final int ticketRouteId;

  @HiveField(2)
  final int fromTicketCounterId;

  @HiveField(3)
  final int toTicketCounterId;

  @HiveField(4)
  final String type;

  @HiveField(5)
  final double price;

  @HiveField(6)
  final bool isAdvanced;

  @HiveField(7)
  final String saleDate;

  @HiveField(8)
  final String? journeyDate;

  @HiveField(9)
  final int userId;

  @HiveField(10)
  final int deviceId;

  LocalTicketSaleModel({
    required this.offid,
    required this.ticketRouteId,
    required this.fromTicketCounterId,
    required this.toTicketCounterId,
    required this.type,
    required this.price,
    required this.isAdvanced,
    required this.saleDate,
    this.journeyDate,
    required this.userId,
    required this.deviceId,
  });

  // Convert to JSON for syncing with server
  Map<String, dynamic> toJson() {
    return {
      'offid': offid,
      'ticket_route_id': ticketRouteId,
      'from_ticket_counter_id': fromTicketCounterId,
      'to_ticket_counter_id': toTicketCounterId,
      'type': type,
      'price': price,
      'is_advanced': isAdvanced,
      'sale_date': saleDate,
      'jounery_date': journeyDate,
      'user_id': userId,
      'device_id': deviceId,
    };
  }

  // Factory constructor for creating an instance from JSON
  factory LocalTicketSaleModel.fromJson(Map<String, dynamic> json) {
    return LocalTicketSaleModel(
      offid: json['offid'],
      ticketRouteId: json['ticket_route_id'],
      fromTicketCounterId: json['from_ticket_counter_id'],
      toTicketCounterId: json['to_ticket_counter_id'],
      type: json['type'],
      price: json['price'].toDouble(),
      isAdvanced: json['is_advanced'],
      saleDate: json['sale_date'],
      journeyDate: json['jounery_date'],
      userId: json['user_id'],
      deviceId: json['device_id'],
    );
  }
}
