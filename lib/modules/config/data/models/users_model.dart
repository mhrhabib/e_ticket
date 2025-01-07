class UserResponse {
  bool? status;
  List<User>? data;

  UserResponse({this.status, this.data});

  UserResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <User>[];
      json['data'].forEach((v) {
        data!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
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
  String? joinDate;
  dynamic address;
  dynamic image;
  String? status;
  String? createdAt;
  String? updatedAt;

  User({this.id, this.name, this.ticketCounterId, this.deviceId, this.username, this.mobile, this.email, this.emailVerifiedAt, this.type, this.roleId, this.joinDate, this.address, this.image, this.status, this.createdAt, this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
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
