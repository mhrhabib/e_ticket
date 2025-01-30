import 'package:dio/dio.dart' as dio;
import 'package:e_ticket/core/common/helper/base_client.dart';
import 'package:e_ticket/core/common/helper/storage.dart';
import 'package:e_ticket/core/utils/urls.dart';
import '../models/login_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel> login(String email, String password);
  Future<Map<String, dynamic>> logOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final dio.Dio client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<LoginModel> login(String email, String password) async {
    final response = await BaseClient.post(
      url: Urls.loginUrl,
      data: {'identifier': email, 'password': password},
    );

    if (response.statusCode == 200) {
      print(response.data);
      return LoginModel.fromJson(response.data);
    } else {
      throw Exception('Failed to login');
    }
  }

  @override
  Future<Map<String, dynamic>> logOut() async {
    dio.Response response = await BaseClient.post(url: "${Urls.baseUrl}/logout");
    if (response.statusCode == 200) {
      storage.remove('token');
      return response.data;
    } else {
      throw Exception('Failed to logout');
    }
  }
}
