import 'package:e_ticket/core/common/helper/base_client.dart';
import 'package:e_ticket/core/utils/urls.dart';
import '../domain/models/device_info_model.dart';
import 'package:dio/dio.dart' as dio;

class RemoteDataSource {
  Future<List<Data>> getAuthorizedDevices() async {
    dio.Response response = await BaseClient.get(url: '${Urls.baseUrl}/get/devices');

    if (response.statusCode == 200) {
      final DeviceInfoModel deviceInfoModel = DeviceInfoModel.fromJson(response.data);
      return deviceInfoModel.data ?? [];
    } else {
      throw Exception('Failed to load authorized devices');
    }
  }
}
