import 'package:e_ticket/core/common/helper/base_client.dart';
import 'package:e_ticket/core/utils/urls.dart';
import 'package:hive/hive.dart';
import '../../../modules/tickets/data/models/sale_model.dart';

class SaleService {
  final box = Hive.box<SaleModel>('sales');

  Future<List<SaleModel>> getSalesFromHive() async {
    return box.values.toList();
  }

  Future<void> postSales(List<SaleModel> sales) async {
    final List<Map<String, dynamic>> data = sales.map((sale) => sale.toMap()).toList();
    try {
      final response = await BaseClient.post(
        url: '${Urls.baseUrl}/admin/ticketssales/recall',
        data: data,
      );

      if (response.statusCode == 201) {
        print('Sales successfully posted');
        box.clear();
      } else {
        print('Failed to post sales');
      }
    } catch (e) {
      print('Error posting sales: $e');
    }
  }
}
