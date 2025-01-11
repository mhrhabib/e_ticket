import 'package:e_ticket/core/common/helper/storage.dart';
import 'package:e_ticket/core/utils/colors_palate.dart';
import 'package:e_ticket/modules/tickets/data/models/ticket_fare_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';
import 'package:sunmi_printer_plus/core/sunmi/sunmi_printer.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

import '../../../../tickets/presentation/cubit/ticket_sale_cubit.dart';

Widget buildTicketList({BuildContext? context, List<Prices>? items, bool? isStudent, bool? isAdvanced, String? selectedDate}) {
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
          onTap: () async {
            if (isAdvanced! && selectedDate == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select a journey date'),
                ),
              );
              return;
            }

            if (storage.read('userId') != null && storage.read('counterId') != null) {
              context.read<TicketSaleCubit>().addTicketSale(
                    userId: storage.read('userId'),
                    ticketRouteId: items[index].routeId!,
                    fromTicketCounterId: storage.read('counterId'),
                    toTicketCounterId: items[index].toTicketCounterId!,
                    type: isStudent ? 'Student' : 'General',
                    price: isStudent ? discountedPrice.toDouble() : originalPrice.toDouble(),
                    isAdvanced: isAdvanced ? true : false,
                    deviceId: 1,
                    journeyDate: isAdvanced ? selectedDate : '',
                  );

              // Print ticket using Sunmi Printer Plus
              await printTicketWithSunmi(
                ticketInfo: {
                  'route': items[index].toTicketCounterNameBn!,
                  'price': isStudent ? discountedPrice.toString() : originalPrice.toString(),
                  'type': isStudent ? 'Student' : 'General',
                  'date': selectedDate ?? 'Today',
                },
              );
            }
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
      });
}

Future<void> printTicketWithSunmi({required Map<String, String> ticketInfo}) async {
  try {
    // Print the header
    final status = await SunmiPrinterPlus().getStatus();
    debugPrint('Printer Status: $status');

    await SunmiPrinter.printText(
      'Ticket Receipt',
      style: SunmiTextStyle(
        bold: true,
        fontSize: 18,
        align: SunmiPrintAlign.CENTER,
      ),
    );
    await SunmiPrinter.lineWrap(1);

    // Print ticket details
    await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);
    await SunmiPrinter.printText('Route: ${ticketInfo['route']}');
    await SunmiPrinter.printText('Type: ${ticketInfo['type']}');
    await SunmiPrinter.printText('Price: ${ticketInfo['price']} BDT');
    await SunmiPrinter.printText('Date: ${ticketInfo['date']}');

    await SunmiPrinter.lineWrap(1);

    // Print footer
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText('Thank you for choosing us!');
    await SunmiPrinter.lineWrap(2);

    // Cut paper if the printer supports it
    await SunmiPrinter.cutPaper();
  } catch (e) {
    debugPrint('Error while printing ticket: $e');
  }
}
