class TicketTypeModel {
  bool? status;
  List<TicketType>? data;

  TicketTypeModel({this.status, this.data});

  TicketTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TicketType>[];
      json['data'].forEach((v) {
        data!.add(TicketType.fromJson(v));
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

class TicketType {
  int? id;
  String? name;
  String? status;
  String? createdAt;
  String? updatedAt;

  TicketType({this.id, this.name, this.status, this.createdAt, this.updatedAt});

  TicketType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
