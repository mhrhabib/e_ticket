class User {
  final int id;
  final String name;
  final String username;
  final String mobile;
  final String email;
  final String status;
  final String? joinDate;
  final String? address;
  final String? image;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.mobile,
    required this.email,
    required this.status,
    this.joinDate,
    this.address,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      mobile: json['mobile'],
      email: json['email'],
      status: json['status'],
      joinDate: json['join_date'],
      address: json['address'],
      image: json['image'],
    );
  }
}

class UserResponse {
  final bool status;
  final List<User> data;

  UserResponse({
    required this.status,
    required this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<User> userList = list.map((i) => User.fromJson(i)).toList();
    return UserResponse(
      status: json['status'],
      data: userList,
    );
  }
}
