import 'package:e_ticket/modules/tickets/data/models/sale_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';
import '../../../../../core/common/helper/storage.dart';
import '../../../../../core/utils/colors_palate.dart';
import '../../../../tickets/data/models/ticket_fare_model.dart';

Widget buildTicketList({
  BuildContext? context,
  List<Prices>? items,
  bool? isStudent,
  bool? isAdvanced,
  String? selectedDate,
}) {
  return GridView.builder(
    padding: EdgeInsets.all(8),
    itemCount: items!.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1.2,
    ),
    itemBuilder: (context, index) {
      final int originalPrice = items[index].generalPrice!;
      final int discountedPrice = isStudent! ? items[index].studentPrice! : originalPrice;

      return InkWell(
        onTap: () {
          if (isAdvanced! && selectedDate == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please select a journey date'),
              ),
            );
            return;
          }

          // Generate a unique offid using UUID
          String offid = Uuid().v4();

          // Create a SaleModel object
          SaleModel sale = SaleModel(
            offid: offid,
            ticketRouteId: items[index].routeId,
            fromTicketCounterId: storage.read('counterId'),
            toTicketCounterId: items[index].toTicketCounterId!,
            type: isStudent ? 'Student' : 'General',
            price: isStudent ? discountedPrice.toDouble() : originalPrice.toDouble(),
            isAdvanced: isAdvanced! ? true : false,
            saleDate: DateTime.now().toString(),
            journeyDate: isAdvanced! ? selectedDate : null,
            userId: storage.read('userId'),
            deviceId: 1, // Use appropriate device ID if needed
          );

          // Store the sale object locally using Hive
          Box<SaleModel> saleBox = Hive.box<SaleModel>('sales');
          saleBox.add(sale);

          isAdvanced = false;
          selectedDate = null;

          // Optionally, show a success message
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sale added to list locally!')),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: ColorsPalate.secondaryColor,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10.0,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                items[index].toTicketCounterNameBn!,
                style: TextStyle(
                  fontSize: 20,
                  color: ColorsPalate.onPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                isStudent ? '$discountedPrice' : '$originalPrice',
                style: TextStyle(
                  fontSize: 24,
                  color: ColorsPalate.onPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}


  // if (isAdvanced! && selectedDate == null) {
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               const SnackBar(
  //                 content: Text('Please select a journey date'),
  //               ),
  //             );
  //             return;
  //           }

  //           if (storage.read('userId') != null && storage.read('counterId') != null) {
  //             context.read<TicketSaleCubit>().addTicketSale(
  //                   userId: storage.read('userId'),
  //                   ticketRouteId: items[index].routeId!,
  //                   fromTicketCounterId: storage.read('counterId'),
  //                   toTicketCounterId: items[index].toTicketCounterId!,
  //                   type: isStudent ? 'Student' : 'General',
  //                   price: isStudent ? discountedPrice.toDouble() : originalPrice.toDouble(),
  //                   isAdvanced: isAdvanced ? true : false,
  //                   deviceId: 1,
  //                   journeyDate: isAdvanced ? selectedDate : '',
  //                 );
  //           }