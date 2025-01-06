class ProfilesModel {
  bool? status;
  Data? data;

  ProfilesModel({this.status, this.data});

  ProfilesModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  int? ticketCounterId;
  int? deviceId;
  String? username;
  String? mobile;
  String? email;
  dynamic emailVerifiedAt;
  String? type;
  int? roleId;
  dynamic joinDate;
  dynamic address;
  dynamic image;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data({this.id, this.name, this.ticketCounterId, this.deviceId, this.username, this.mobile, this.email, this.emailVerifiedAt, this.type, this.roleId, this.joinDate, this.address, this.image, this.status, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ticketCounterId = json['ticket_counter_id'];
    deviceId = json['device_id'];
    username = json['username'];
    mobile = json['mobile'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    type = json['type'];
    roleId = json['role_id'];
    joinDate = json['join_date'];
    address = json['address'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['ticket_counter_id'] = ticketCounterId;
    data['device_id'] = deviceId;
    data['username'] = username;
    data['mobile'] = mobile;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['type'] = type;
    data['role_id'] = roleId;
    data['join_date'] = joinDate;
    data['address'] = address;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
