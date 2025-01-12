import 'package:e_ticket/core/common/helper/base_client.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/core/utils/urls.dart';
import 'package:e_ticket/modules/dashboard/data/models/dashboard_model.dart';

abstract class DashboardReomoteDataSource {
  Future<DashboardModel> getDashbordData();
}

class DashboardRemoteDataSourceImpl extends DashboardReomoteDataSource {
  @override
  Future<DashboardModel> getDashbordData() async {
    try {
      final response = await BaseClient.get(url: '${Urls.baseUrl}/dashboard/summery');
      return DashboardModel.fromJson(response.data);
    } on ClientException catch (e) {
      throw ValidationFailure(message: e.message);
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    } catch (e) {
      throw NetworkFailure(message: 'Unexpected error: $e');
    }
  }
}
