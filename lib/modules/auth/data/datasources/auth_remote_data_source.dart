import 'package:dio/dio.dart';
import '../models/login_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<LoginModel> login(String email, String password) async {
    final response = await client.post(
      '/login', // Replace with the correct endpoint
      data: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      print(response.data);
      return LoginModel.fromJson(response.data);
    } else {
      throw Exception('Failed to login');
    }
  }
}
