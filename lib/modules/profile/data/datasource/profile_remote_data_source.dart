import 'package:e_ticket/core/common/helper/base_client.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/core/utils/urls.dart';
import 'package:e_ticket/modules/profile/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfilesModel> fetchProfilesData();
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  @override
  Future<ProfilesModel> fetchProfilesData() async {
    try {
      final response = await BaseClient.get(url: '${Urls.baseUrl}/admin/profile');
      return ProfilesModel.fromJson(response.data);
    } on ClientException catch (e) {
      throw ValidationFailure(message: e.message);
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    } catch (e) {
      throw NetworkFailure(message: 'Unexpected error: $e');
    }
  }
}
