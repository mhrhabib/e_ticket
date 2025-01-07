class TicketSaleModel {
  bool? status;
  String? message;
  Data? data;

  TicketSaleModel({this.status, this.message, this.data});

  TicketSaleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? tuid;
  String? ticketRouteName;
  int? ticketRouteId;
  String? fromTicketCounterName;
  int? fromTicketCounterId;
  String? toTicketCounterName;
  int? toTicketCounterId;
  String? type;
  int? price;
  bool? isAdvanced;
  String? jouneryDate;
  String? saleDate;
  int? userId;
  String? userName;
  int? deviceId;

  Data(
      {this.id,
      this.tuid,
      this.ticketRouteName,
      this.ticketRouteId,
      this.fromTicketCounterName,
      this.fromTicketCounterId,
      this.toTicketCounterName,
      this.toTicketCounterId,
      this.type,
      this.price,
      this.isAdvanced,
      this.jouneryDate,
      this.saleDate,
      this.userId,
      this.userName,
      this.deviceId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tuid = json['tuid'];
    ticketRouteName = json['ticket_route_name'];
    ticketRouteId = json['ticket_route_id'];
    fromTicketCounterName = json['from_ticket_counter_name'];
    fromTicketCounterId = json['from_ticket_counter_id'];
    toTicketCounterName = json['to_ticket_counter_name'];
    toTicketCounterId = json['to_ticket_counter_id'];
    type = json['type'];
    price = json['price'];
    isAdvanced = json['is_advanced'];
    jouneryDate = json['jounery_date'];
    saleDate = json['sale_date'];
    userId = json['user_id'];
    userName = json['user_name'];
    deviceId = json['device_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tuid'] = tuid;
    data['ticket_route_name'] = ticketRouteName;
    data['ticket_route_id'] = ticketRouteId;
    data['from_ticket_counter_name'] = fromTicketCounterName;
    data['from_ticket_counter_id'] = fromTicketCounterId;
    data['to_ticket_counter_name'] = toTicketCounterName;
    data['to_ticket_counter_id'] = toTicketCounterId;
    data['type'] = type;
    data['price'] = price;
    data['is_advanced'] = isAdvanced;
    data['jounery_date'] = jouneryDate;
    data['sale_date'] = saleDate;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['device_id'] = deviceId;
    return data;
  }
}
