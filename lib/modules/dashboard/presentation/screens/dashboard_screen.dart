import 'package:e_ticket/app/di.dart';
import 'package:e_ticket/core/utils/colors_palate.dart';
import 'package:e_ticket/modules/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:e_ticket/modules/home/presentation/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';
import 'package:sunmi_printer_plus/core/sunmi/sunmi_printer.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsPalate.primaryColor,
        title: Text(
          'Dashboard',
          style: TextStyle(color: ColorsPalate.onPrimaryColor),
        ),
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
          bloc: DashboardCubit(dashboardUsecase: sl()),
          builder: (context, state) {
            if (state is DashboardLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: ColorsPalate.primaryColor,
                ),
              );
            }
            if (state is DashboardFailed) {
              return Center(
                child: Text("data"),
              );
            }

            if (state is DashboardSuccess) {
              final count = state.dashboardModel.data;
              return Column(
                children: [
                  Wrap(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                              },
                              icon: Icon(Icons.bus_alert),
                              label: Text('Sale Ticket')),
                        ),
                      ),
                      _buildTicketCountsWidget(context, count!.totaltickets.toString(), 'Total Tickets'),
                      _buildTicketCountsWidget(context, count.totalticketfare.toString(), 'Total Tickets Fare'),
                      _buildTicketCountsWidget(context, count.totaladvancedtickets.toString(), 'Total  Advanced Tickets '),
                      _buildTicketCountsWidget(context, count.totaladvancedticketfare.toString(), 'Total Advanced Tickets Fare'),
                      _buildTicketCountsWidget(context, count.totalstudenttickets.toString(), 'Total Student Tickets'),
                      _buildTicketCountsWidget(context, count.totalstudentticketfare.toString(), 'Total Student Ticket Fare'),
                    ],
                  ),
                  Gap(20),
                  OutlinedButton(
                      onPressed: () async {
                        final ticketInfo = {
                          "totaltickets": count.totaltickets.toString(),
                          "totalticketfare": count.totalticketfare.toString(),
                          "totaladvancedtickets": count.totaladvancedtickets.toString(),
                          "totaladvancedticketfare": count.totaladvancedticketfare.toString(),
                          "totalstudenttickets": count.totalstudenttickets.toString(),
                          "totalstudentticketfare": count.totalstudentticketfare.toString(),
                        };
                        await printTicketWithSunmi(ticketInfo: ticketInfo);
                      },
                      child: Text('Print Report')),
                ],
              );
            }
            return SizedBox.shrink();
          }),
    );
  }

  _buildTicketCountsWidget(BuildContext context, String count, String title) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorsPalate.secondaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.38,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> printTicketWithSunmi({required Map<String, dynamic> ticketInfo}) async {
    try {
      final status = await SunmiPrinterPlus().getStatus();
      debugPrint('Printer Status: $status');

      // Print header
      await SunmiPrinter.printText(
        'Dashboard Report',
        style: SunmiTextStyle(
          bold: true,
          fontSize: 18,
          align: SunmiPrintAlign.CENTER,
        ),
      );
      await SunmiPrinter.lineWrap(1);

      await SunmiPrinter.printText(
        '-----------------',
        style: SunmiTextStyle(
          align: SunmiPrintAlign.CENTER,
        ),
      );

      // Print each data point
      await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);
      await SunmiPrinter.printText('Total Tickets: ${ticketInfo['totaltickets']}');
      await SunmiPrinter.printText('Total Ticket Fare: ${ticketInfo['totalticketfare']} BDT');
      await SunmiPrinter.printText('Advanced Tickets: ${ticketInfo['totaladvancedtickets']}');
      await SunmiPrinter.printText('Advanced Ticket Fare: ${ticketInfo['totaladvancedticketfare']} BDT');
      await SunmiPrinter.printText('Student Tickets: ${ticketInfo['totalstudenttickets']}');
      await SunmiPrinter.printText('Student Ticket Fare: ${ticketInfo['totalstudentticketfare']} BDT');

      await SunmiPrinter.printText(
        '-----------------',
        style: SunmiTextStyle(
          align: SunmiPrintAlign.CENTER,
        ),
      );

      // Print footer
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printText('Thank you for choosing us!');
      await SunmiPrinter.lineWrap(2);

      // Cut paper
      await SunmiPrinter.cutPaper();
    } catch (e) {
      debugPrint('Error while printing report: $e');
    }
  }
}
