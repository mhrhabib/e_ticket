// ignore_for_file: use_build_context_synchronously

import 'package:e_ticket/core/common/helper/time_extention.dart';
import 'package:e_ticket/modules/tickets/data/models/sale_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';
import 'package:sunmi_printer_plus/core/sunmi/sunmi_printer.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';
import '../../../../../core/common/helper/storage.dart';
import '../../../../../core/utils/colors_palate.dart';
import '../../../../tickets/data/models/ticket_fare_model.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

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
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 0.8,
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
            isAdvanced: isAdvanced ? true : false,
            saleDate: DateTime.now().toString(),
            journeyDate: isAdvanced ? selectedDate!.toFormattedDate() : DateTime.now().toString(),
            userId: storage.read('userId'),
            deviceId: 1, // Use appropriate device ID if needed
          );

          // Store the sale object locally using Hive
          Box<SaleModel> saleBox = Hive.box<SaleModel>('sales');
          saleBox.add(sale);

          print(DateTime.now().toString().toFormattedDate());

          await printTicketWithSunmi(
            ticketInfo: {
              'route': items[index].toTicketCounterNameBn!,
              'price': isStudent ? discountedPrice.toString() : originalPrice.toString(),
              'type': isStudent ? 'Student' : 'General',
              'date': selectedDate != null ? selectedDate.toFormattedDate() : DateTime.now().toString().toFormattedDate(),
              'from_counter_name': storage.read('fromCounterName'),
              'to_counter_name': items[index].toTicketCounterNameBn!,
            },
          );

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                items[index].toTicketCounterNameBn!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: ColorsPalate.onPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(12),
              Text(
                isStudent ? '$discountedPrice' : '$originalPrice',
                style: TextStyle(
                  fontSize: 18,
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

Future<void> printTicketWithSunmi({required Map<String, String> ticketInfo}) async {
  try {
    // Print the header
    final status = await SunmiPrinterPlus().getStatus();
    debugPrint('Printer Status: $status');

    await SunmiPrinter.printText(
      '${ticketInfo['from_counter_name']}/${ticketInfo['type']}',
      style: SunmiTextStyle(
        bold: true,
        fontSize: 22,
        align: SunmiPrintAlign.CENTER,
      ),
    );
    await SunmiPrinter.printText(
      'হাতিরঝিল চক্রাকার বাস সার্ভিস',
      style: SunmiTextStyle(
        bold: true,
        fontSize: 22,
        align: SunmiPrintAlign.CENTER,
      ),
    );
    await SunmiPrinter.lineWrap(2);

    // Print ticket details
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText('${ticketInfo['from_counter_name']} টু ${ticketInfo['to_counter_name']}',
        style: SunmiTextStyle(
          bold: true,
          fontSize: 22,
          align: SunmiPrintAlign.CENTER,
        ));
    await SunmiPrinter.printText('তারিখঃ${ticketInfo['date']} ইং');
    await SunmiPrinter.lineWrap(2);

    await SunmiPrinter.printText(
      'Price: ${ticketInfo['price']} BDT',
      style: SunmiTextStyle(
        bold: true,
        fontSize: 26,
        align: SunmiPrintAlign.CENTER,
      ),
    );

    await SunmiPrinter.lineWrap(2);

    // Print footer
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText('চেকিং এর জন্য টিকিট সংরক্ষন করুন',
        style: SunmiTextStyle(
          fontSize: 12,
        ));
    await SunmiPrinter.printText('বিক্রিত টিকেট ফেরত হবেনা',
        style: SunmiTextStyle(
          fontSize: 12,
        ));
    await SunmiPrinter.printText('অভিযোগ ও পরামর্শ- info@hr-transport.net',
        style: SunmiTextStyle(
          fontSize: 12,
        ));

    // Cut paper if the printer supports it
    await SunmiPrinter.cutPaper();
  } catch (e) {
    debugPrint('Error while printing ticket: $e');
  }
}
