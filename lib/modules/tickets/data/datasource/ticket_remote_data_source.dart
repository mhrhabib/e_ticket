import 'package:e_ticket/core/common/helper/base_client.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/core/utils/urls.dart';
import 'package:e_ticket/modules/tickets/data/models/tickets_model.dart';

abstract class TicketRemoteDataSource {
  Future<TicketsModel> getTicketsList();
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
}
