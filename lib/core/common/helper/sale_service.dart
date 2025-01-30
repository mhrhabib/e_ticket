import 'package:e_ticket/core/common/helper/base_client.dart';
import 'package:e_ticket/core/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        box.clear();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Fluttertoast.showToast(
            msg: "Sales successfully posted",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Fluttertoast.showToast(
            msg: "Failed to post sales",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        });
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Fluttertoast.showToast(
          msg: "Error posting sales: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      });
    }
  }
}
