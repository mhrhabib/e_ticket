class DashboardModel {
  bool? status;
  Data? data;

  DashboardModel({this.status, this.data});

  DashboardModel.fromJson(Map<String, dynamic> json) {
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
  int? totaltickets;
  int? totalticketfare;
  int? totaladvancedtickets;
  int? totaladvancedticketfare;
  int? totalstudenttickets;
  int? totalstudentticketfare;
  int? tenqty;
  int? fifteenqty;
  int? twentyqty;
  int? twentyfiveqty;
  int? fourtyqty;

  Data({this.totaltickets, this.totalticketfare, this.totaladvancedtickets, this.totaladvancedticketfare, this.totalstudenttickets, this.totalstudentticketfare, this.tenqty, this.fifteenqty, this.twentyqty, this.twentyfiveqty, this.fourtyqty});

  Data.fromJson(Map<String, dynamic> json) {
    totaltickets = json['totaltickets'];
    totalticketfare = json['totalticketfare'];
    totaladvancedtickets = json['totaladvancedtickets'];
    totaladvancedticketfare = json['totaladvancedticketfare'];
    totalstudenttickets = json['totalstudenttickets'];
    totalstudentticketfare = json['totalstudentticketfare'];
    tenqty = json['tenqty'];
    fifteenqty = json['fifteenqty'];
    twentyqty = json['twentyqty'];
    twentyfiveqty = json['twentyfiveqty'];
    fourtyqty = json['fourtyqty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totaltickets'] = totaltickets;
    data['totalticketfare'] = totalticketfare;
    data['totaladvancedtickets'] = totaladvancedtickets;
    data['totaladvancedticketfare'] = totaladvancedticketfare;
    data['totalstudenttickets'] = totalstudenttickets;
    data['totalstudentticketfare'] = totalstudentticketfare;
    data['tenqty'] = tenqty;
    data['fifteenqty'] = fifteenqty;
    data['twentyqty'] = twentyqty;
    data['twentyfiveqty'] = twentyfiveqty;
    data['fourtyqty'] = fourtyqty;
    return data;
  }
}
