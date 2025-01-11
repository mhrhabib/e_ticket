import 'package:hive/hive.dart';

part 'ticket_fare_model.g.dart';

@HiveType(typeId: 0)
class TicketFareModel {
  @HiveField(0)
  bool? status;

  @HiveField(1)
  String? message;

  @HiveField(2)
  List<Prices>? prices;

  TicketFareModel({this.status, this.message, this.prices});

  factory TicketFareModel.fromJson(Map<String, dynamic> json) {
    return TicketFareModel(
      status: json['status'],
      message: json['message'],
      prices: (json['prices'] as List<dynamic>?)?.map((e) => Prices.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'prices': prices?.map((e) => e.toJson()).toList(),
    };
  }
}

@HiveType(typeId: 1)
class Prices {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? studentPrice;

  @HiveField(2)
  int? generalPrice;

  @HiveField(3)
  String? toTicketCounterName;

  @HiveField(4)
  String? toTicketCounterNameBn;

  @HiveField(5)
  int? toTicketCounterId;

  @HiveField(6)
  String? routeName;

  @HiveField(7)
  int? routeId;

  Prices({this.id, this.studentPrice, this.generalPrice, this.toTicketCounterName, this.toTicketCounterNameBn, this.toTicketCounterId, this.routeName, this.routeId});

  factory Prices.fromJson(Map<String, dynamic> json) {
    return Prices(
      id: json['id'],
      studentPrice: json['student_price'],
      generalPrice: json['general_price'],
      toTicketCounterName: json['to_ticket_counter_name'],
      toTicketCounterNameBn: json['to_ticket_counter_name_bn'],
      toTicketCounterId: json['to_ticket_counter_id'],
      routeName: json['route_name'],
      routeId: json['route_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_price': studentPrice,
      'general_price': generalPrice,
      'to_ticket_counter_name': toTicketCounterName,
      'to_ticket_counter_name_bn': toTicketCounterNameBn,
      'to_ticket_counter_id': toTicketCounterId,
      'route_name': routeName,
      'route_id': routeId,
    };
  }
}
