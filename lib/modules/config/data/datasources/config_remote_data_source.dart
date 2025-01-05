import 'package:dio/dio.dart';
import 'package:e_ticket/modules/config/data/models/counter_model.dart';
import 'package:e_ticket/modules/config/data/models/ticket_routes_model.dart';
import 'package:e_ticket/modules/config/data/models/ticket_type_model.dart';
import '../models/users_model.dart';

abstract class ConfigRemoteDataSource {
  Future<UserResponse> fetchUsers();
  Future<TicketTypeModel> fetchTicketTypes();
  Future<TicketRoutesModel> fetchTicketRoutes();
  Future<CounterModel> fetchCounters();
}

class ConfigRemoteDataSourceImpl implements ConfigRemoteDataSource {
  final Dio client;

  ConfigRemoteDataSourceImpl({required this.client});

  @override
  Future<UserResponse> fetchUsers() async {
    try {
      final response = await client.get('/admin/users');
      return UserResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  @override
  Future<TicketRoutesModel> fetchTicketRoutes() async {
    try {
      final response = await client.get('/admin/ticketroutes');
      return TicketRoutesModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  @override
  Future<TicketTypeModel> fetchTicketTypes() async {
    try {
      final response = await client.get('/admin/ticket-types');
      return TicketTypeModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  @override
  Future<CounterModel> fetchCounters() async {
    try {
      final response = await client.get('/admin/ticketcounters');
      return CounterModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }
}
