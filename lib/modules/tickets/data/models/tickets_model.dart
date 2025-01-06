class TicketsModel {
  bool? status;
  Tickets? data;

  TicketsModel({this.status, this.data});

  TicketsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Tickets.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Tickets {
  int? currentPage;
  List<Ticket>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Tickets({this.currentPage, this.data, this.firstPageUrl, this.from, this.lastPage, this.lastPageUrl, this.links, this.nextPageUrl, this.path, this.perPage, this.prevPageUrl, this.to, this.total});

  Tickets.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Ticket>[];
      json['data'].forEach((v) {
        data!.add(Ticket.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Ticket {
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
  dynamic jouneryDate;
  String? saleDate;
  int? userId;
  String? userName;
  int? deviceId;

  Ticket(
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

  Ticket.fromJson(Map<String, dynamic> json) {
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

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
