import 'package:e_ticket/core/common/helper/base_client.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/core/utils/urls.dart';
import 'package:e_ticket/modules/tickets/data/models/ticket_fare_model.dart';
import 'package:e_ticket/modules/tickets/data/models/ticket_sale_model.dart';
import 'package:e_ticket/modules/tickets/data/models/tickets_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class TicketRemoteDataSource {
  Future<TicketsModel> getTicketsList();
  Future<TicketFareModel> getTicketFare();
  Future<TicketSaleModel> addTicketSale({
    required int userId,
    required int ticketRouteId,
    required int fromTicketCounterId,
    required int toTicketCounterId,
    required String type,
    required double price,
    required bool isAdvanced,
    required int deviceId,
    required String journeyDate,
  });
}

class TicketRemoteDataSourceImpl extends TicketRemoteDataSource {
  @override
  Future<TicketsModel> getTicketsList() async {
    try {
      final response = await BaseClient.get(url: '${Urls.baseUrl}/admin/ticketssales');
      return TicketsModel.fromJson(response.data);
    } on ClientException catch (e) {
      throw ValidationFailure(message: e.message);
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    } catch (e) {
      throw NetworkFailure(message: 'Unexpected error: $e');
    }
  }

  @override
  Future<TicketSaleModel> addTicketSale({
    required int userId,
    required int ticketRouteId,
    required int fromTicketCounterId,
    required int toTicketCounterId,
    required String type,
    required double price,
    required bool isAdvanced,
    required int deviceId,
    required String journeyDate,
  }) async {
    final data = {
      "user_id": userId,
      "ticket_route_id": ticketRouteId,
      "from_ticket_counter_id": fromTicketCounterId,
      "to_ticket_counter_id": toTicketCounterId,
      "type": type,
      "price": price,
      "is_advanced": isAdvanced ? 1 : 0,
      "device_id": deviceId,
      "jounery_date": journeyDate,
    };
    print(data);
    try {
      final response = await BaseClient.post(url: '${Urls.baseUrl}/admin/ticketssales/add', data: data);
      return TicketSaleModel.fromJson(response.data);
    } on ClientException catch (e) {
      throw ValidationFailure(message: e.message);
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    } catch (e) {
      throw NetworkFailure(message: 'Unexpected error: $e');
    }
  }

  @override
  Future<TicketFareModel> getTicketFare() async {
    final box = Hive.box<TicketFareModel>('fareBox');
    try {
      final response = await BaseClient.post(url: '${Urls.baseUrl}/admin/ticketfare');
      // Save the data to Hive
      final ticketFareModel = TicketFareModel.fromJson(response.data);
      box.put('fareData', ticketFareModel);
      return ticketFareModel;
    } on ClientException catch (e) {
      // Return cached data if available
      final cachedData = box.get('fareData');
      if (cachedData != null) {
        return cachedData;
      }
      throw ValidationFailure(message: e.message);
    } on ServerException catch (e) {
      final cachedData = box.get('fareData');
      if (cachedData != null) {
        return cachedData;
      }
      throw ServerFailure(message: e.message);
    } catch (e) {
      final cachedData = box.get('fareData');
      if (cachedData != null) {
        return cachedData;
      }
      throw NetworkFailure(message: 'Unexpected error: $e');
    }
  }
}
