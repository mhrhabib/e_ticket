import 'package:hive/hive.dart';

part 'local_ticket_fare_model.g.dart';

@HiveType(typeId: 1) // Use a unique typeId for this model
class LocalTicketFareModel {
  @HiveField(0)
  final int routeId;

  @HiveField(1)
  final int fromCounterId;

  @HiveField(2)
  final int toCounterId;

  @HiveField(3)
  final String type;

  @HiveField(4)
  final double price;

  LocalTicketFareModel({
    required this.routeId,
    required this.fromCounterId,
    required this.toCounterId,
    required this.type,
    required this.price,
  });

  // Convert to JSON for syncing or other operations
  Map<String, dynamic> toJson() {
    return {
      'route_id': routeId,
      'from_counter_id': fromCounterId,
      'to_counter_id': toCounterId,
      'type': type,
      'price': price,
    };
  }

  // Factory constructor for creating an instance from JSON
  factory LocalTicketFareModel.fromJson(Map<String, dynamic> json) {
    return LocalTicketFareModel(
      routeId: json['route_id'],
      fromCounterId: json['from_counter_id'],
      toCounterId: json['to_counter_id'],
      type: json['type'],
      price: json['price'].toDouble(),
    );
  }
}
