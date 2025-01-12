class LoginModel {
  bool? status;
  Data? data;

  LoginModel({this.status, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  String? token;
  User? user;

  Data({this.token, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? username;
  int? ticketCounterId;
  String? fromTicketCounterName;
  String? fromTicketCounterNameBn;
  int? deviceId;
  String? mobile;
  String? address;

  User({this.id, this.name, this.username, this.ticketCounterId, this.fromTicketCounterName, this.fromTicketCounterNameBn, this.deviceId, this.mobile, this.address});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    ticketCounterId = json['ticket_counter_id'];
    fromTicketCounterName = json['from_ticket_counter_name'];
    fromTicketCounterNameBn = json['from_ticket_counter_name_bn'];
    deviceId = json['device_id'];
    mobile = json['mobile'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['ticket_counter_id'] = ticketCounterId;
    data['from_ticket_counter_name'] = fromTicketCounterName;
    data['from_ticket_counter_name_bn'] = fromTicketCounterNameBn;
    data['device_id'] = deviceId;
    data['mobile'] = mobile;
    data['address'] = address;
    return data;
  }
}
