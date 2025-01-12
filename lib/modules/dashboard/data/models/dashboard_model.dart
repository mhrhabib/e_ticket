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

  Data({this.totaltickets, this.totalticketfare, this.totaladvancedtickets, this.totaladvancedticketfare, this.totalstudenttickets, this.totalstudentticketfare});

  Data.fromJson(Map<String, dynamic> json) {
    totaltickets = json['totaltickets'];
    totalticketfare = json['totalticketfare'];
    totaladvancedtickets = json['totaladvancedtickets'];
    totaladvancedticketfare = json['totaladvancedticketfare'];
    totalstudenttickets = json['totalstudenttickets'];
    totalstudentticketfare = json['totalstudentticketfare'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totaltickets'] = totaltickets;
    data['totalticketfare'] = totalticketfare;
    data['totaladvancedtickets'] = totaladvancedtickets;
    data['totaladvancedticketfare'] = totaladvancedticketfare;
    data['totalstudenttickets'] = totalstudenttickets;
    data['totalstudentticketfare'] = totalstudentticketfare;
    return data;
  }
}
