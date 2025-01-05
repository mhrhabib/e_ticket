class TicketRoutesModel {
  bool? status;
  List<TicketRoute>? data;

  TicketRoutesModel({this.status, this.data});

  TicketRoutesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TicketRoute>[];
      json['data'].forEach((v) {
        data!.add(TicketRoute.fromJson(v));
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

class TicketRoute {
  int? id;
  String? name;
  String? nameBn;
  String? status;
  String? createdAt;
  String? updatedAt;

  TicketRoute({this.id, this.name, this.nameBn, this.status, this.createdAt, this.updatedAt});

  TicketRoute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameBn = json['name_bn'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['name_bn'] = nameBn;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
