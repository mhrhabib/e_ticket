// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'sale_model.g.dart';

@HiveType(typeId: 2)
class SaleModel {
  @HiveField(0)
  String? offid;

  @HiveField(1)
  int? ticketRouteId;

  @HiveField(2)
  int? fromTicketCounterId;

  @HiveField(3)
  int? toTicketCounterId;

  @HiveField(4)
  String? type;

  @HiveField(5)
  double? price;

  @HiveField(6)
  bool? isAdvanced;

  @HiveField(7)
  String? saleDate;

  @HiveField(8)
  String? journeyDate;

  @HiveField(9)
  int? userId;

  @HiveField(10)
  int? deviceId;

  SaleModel({
    this.offid,
    this.ticketRouteId,
    this.fromTicketCounterId,
    this.toTicketCounterId,
    this.type,
    this.price,
    this.isAdvanced,
    this.saleDate,
    this.journeyDate,
    this.userId,
    this.deviceId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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

  factory SaleModel.fromMap(Map<String, dynamic> map) {
    return SaleModel(
      offid: map['offid'] != null ? map['offid'] as String : null,
      ticketRouteId: map['ticket_route_id'] != null ? map['ticket_route_id'] as int : null,
      fromTicketCounterId: map['from_ticket_counter_id'] != null ? map['from_ticket_counter_id'] as int : null,
      toTicketCounterId: map['to_ticket_counter_id'] != null ? map['to_ticket_counter_id'] as int : null,
      type: map['type'] != null ? map['type'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
      isAdvanced: map['is_advanced'] != null ? map['is_advanced'] as bool : null,
      saleDate: map['sale_date'] != null ? map['sale_date'] as String : null,
      journeyDate: map['jounery_date'] != null ? map['jounery_date'] as String : null,
      userId: map['user_id'] != null ? map['user_id'] as int : null,
      deviceId: map['device_id'] != null ? map['device_id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SaleModel.fromJson(String source) => SaleModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
