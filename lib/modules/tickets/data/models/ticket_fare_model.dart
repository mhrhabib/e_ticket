import 'package:hive/hive.dart';

part 'ticket_fare_model.g.dart';

@HiveType(typeId: 0) // Assign a unique typeId for this model.
class TicketFareModel extends HiveObject {
  @HiveField(0)
  bool? status;

  @HiveField(1)
  String? message;

  @HiveField(2)
  List<Prices>? prices;

  TicketFareModel({this.status, this.message, this.prices});

  TicketFareModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['prices'] != null) {
      prices = <Prices>[];
      json['prices'].forEach((v) {
        prices!.add(Prices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    if (prices != null) {
      data['prices'] = prices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@HiveType(typeId: 1) // Assign a unique typeId for this model.
class Prices extends HiveObject {
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
  dynamic counterShortName;

  @HiveField(6)
  dynamic toTicketCounterId;

  @HiveField(7)
  String? routeName;

  @HiveField(8)
  int? routeId;

  Prices({
    this.id,
    this.studentPrice,
    this.generalPrice,
    this.toTicketCounterName,
    this.toTicketCounterNameBn,
    this.counterShortName,
    this.toTicketCounterId,
    this.routeName,
    this.routeId,
  });

  Prices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentPrice = json['student_price'];
    generalPrice = json['general_price'];
    toTicketCounterName = json['to_ticket_counter_name'];
    toTicketCounterNameBn = json['to_ticket_counter_name_bn'];
    counterShortName = json['counter_short_name'];
    toTicketCounterId = json['to_ticket_counter_id'];
    routeName = json['route_name'];
    routeId = json['route_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['student_price'] = studentPrice;
    data['general_price'] = generalPrice;
    data['to_ticket_counter_name'] = toTicketCounterName;
    data['to_ticket_counter_name_bn'] = toTicketCounterNameBn;
    data['counter_short_name'] = counterShortName.toString();
    data['to_ticket_counter_id'] = toTicketCounterId;
    data['route_name'] = routeName;
    data['route_id'] = routeId;
    return data;
  }
}
