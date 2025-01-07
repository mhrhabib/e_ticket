import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/core/common/helper/base_client.dart';
import 'package:e_ticket/core/utils/urls.dart';
import 'package:e_ticket/modules/config/data/models/counter_model.dart';
import 'package:e_ticket/modules/config/data/models/price_model.dart';
import 'package:e_ticket/modules/config/data/models/ticket_routes_model.dart';
import 'package:e_ticket/modules/config/data/models/ticket_type_model.dart';
import '../models/users_model.dart';

abstract class ConfigRemoteDataSource {
  Future<UserResponse> fetchUsers();
  Future<TicketTypeModel> fetchTicketTypes();
  Future<TicketRoutesModel> fetchTicketRoutes();
  Future<CounterModel> fetchCounters();
  Future<PriceModel> getTicketPrice({required String userId, required String ticketRouteId, required String toCounterId, required String type});
}

class ConfigRemoteDataSourceImpl implements ConfigRemoteDataSource {
  @override
  Future<UserResponse> fetchUsers() async {
    try {
      final response = await BaseClient.get(url: '${Urls.baseUrl}/admin/users');
      return UserResponse.fromJson(response.data);
    } on ClientException catch (e) {
      throw ValidationFailure(message: e.message);
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    } catch (e) {
      throw NetworkFailure(message: 'Unexpected error: $e');
    }
  }

  @override
  Future<TicketRoutesModel> fetchTicketRoutes() async {
    try {
      final response = await BaseClient.get(url: '${Urls.baseUrl}/admin/ticketroutes');
      return TicketRoutesModel.fromJson(response.data);
    } on ClientException catch (e) {
      throw ValidationFailure(message: e.message);
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    } catch (e) {
      throw NetworkFailure(message: 'Unexpected error: $e');
    }
  }

  @override
  Future<TicketTypeModel> fetchTicketTypes() async {
    try {
      final response = await BaseClient.get(url: '${Urls.baseUrl}/admin/ticket-types');
      return TicketTypeModel.fromJson(response.data);
    } on ClientException catch (e) {
      throw ValidationFailure(message: e.message);
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    } catch (e) {
      throw NetworkFailure(message: 'Unexpected error: $e');
    }
  }

  @override
  Future<CounterModel> fetchCounters() async {
    try {
      final response = await BaseClient.get(url: '${Urls.baseUrl}/admin/ticketcounters');
      return CounterModel.fromJson(response.data);
    } on ClientException catch (e) {
      throw ValidationFailure(message: e.message);
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    } catch (e) {
      throw NetworkFailure(message: 'Unexpected error: $e');
    }
  }

  @override
  Future<PriceModel> getTicketPrice({required String userId, required String ticketRouteId, required String toCounterId, required String type}) async {
    try {
      final response = await BaseClient.post(url: '${Urls.baseUrl}/admin/ticketfare/getprice', data: {'user_id': userId, 'ticket_route_id': ticketRouteId, 'to_counter_id': toCounterId, 'type': type});
      return PriceModel.fromJson(response.data);
    } on ClientException catch (e) {
      throw ValidationFailure(message: e.message);
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    } catch (e) {
      throw NetworkFailure(message: 'Unexpected error: $e');
    }
  }
}
