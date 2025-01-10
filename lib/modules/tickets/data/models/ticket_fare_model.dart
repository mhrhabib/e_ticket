class TicketFareModel {
  bool? status;
  String? message;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (prices != null) {
      data['prices'] = prices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prices {
  int? id;
  int? studentPrice;
  int? generalPrice;
  String? toTicketCounterName;
  String? toTicketCounterNameBn;
  int? toTicketCounterId;
  String? routeName;
  int? routeId;

  Prices({this.id, this.studentPrice, this.generalPrice, this.toTicketCounterName, this.toTicketCounterNameBn, this.toTicketCounterId, this.routeName, this.routeId});

  Prices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentPrice = json['student_price'];
    generalPrice = json['general_price'];
    toTicketCounterName = json['to_ticket_counter_name'];
    toTicketCounterNameBn = json['to_ticket_counter_name_bn'];
    toTicketCounterId = json['to_ticket_counter_id'];
    routeName = json['route_name'];
    routeId = json['route_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['student_price'] = studentPrice;
    data['general_price'] = generalPrice;
    data['to_ticket_counter_name'] = toTicketCounterName;
    data['to_ticket_counter_name_bn'] = toTicketCounterNameBn;
    data['to_ticket_counter_id'] = toTicketCounterId;
    data['route_name'] = routeName;
    data['route_id'] = routeId;
    return data;
  }
}
