class PriceModel {
  bool? status;
  String? message;
  int? price;

  PriceModel({this.status, this.message, this.price});

  PriceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['price'] = price;
    return data;
  }
}
