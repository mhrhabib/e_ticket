// ignore_for_file: use_build_context_synchronously

import 'package:e_ticket/core/common/helper/sale_service.dart';
import 'package:e_ticket/core/common/helper/storage.dart';
import 'package:e_ticket/core/utils/colors_palate.dart';
import 'package:e_ticket/modules/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_ticket/modules/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:e_ticket/modules/home/presentation/page/home_page.dart';
import 'package:e_ticket/modules/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';
import 'package:sunmi_printer_plus/core/sunmi/sunmi_printer.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

import '../../../auth/presentation/pages/login_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    setState(() {
      context.read<DashboardCubit>().loadDashboardData();
    }); // Initial API call
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Call the API when the app comes back to the foreground
      setState(() {
        context.read<DashboardCubit>().loadDashboardData();
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final SaleService saleService = SaleService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsPalate.primaryColor,
        title: Text(
          'Dashboard',
          style: TextStyle(color: ColorsPalate.buttonFontColor),
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            spacing: 4,
            children: [
              Image.asset(
                'assets/logo.png',
                height: 50,
              ),
              Gap(12),
              Text(
                'HR Transports Agency',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              ListTile(
                leading: Icon(Icons.dashboard_outlined),
                title: Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashboardScreen())),
              ),
              ListTile(
                leading: Icon(Icons.person_4_outlined),
                title: Text('Profile', style: TextStyle(fontSize: 18)),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage())),
              ),
              ListTile(
                leading: Icon(Icons.bus_alert),
                title: Text('Sale Ticket'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('LogOut', style: TextStyle(fontSize: 18)),
                onTap: () async {
                  final hasInternet = await checkInternetConnection();
                  print(">>>>>>>>>>>>>>>>internet = $hasInternet");
                  if (!hasInternet) {
                    // Show a snackbar for no internet
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('No internet connection. Cannot log out.'),
                      ),
                    );
                    return;
                  }
                  final salesList = await saleService.getSalesFromHive();
                  if (salesList.isNotEmpty) {
                    try {
                      // Attempt to post sales data
                      await saleService.postSales(salesList);
                      await clearLocalData();
                      // Logout after successful sync
                      await context.read<AuthCubit>().logOut();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false,
                      );
                    } catch (e) {
                      // Handle API call errors
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to sync sales: $e')),
                      );
                    }
                  } else {
                    // No sales data to sync; proceed with logout
                    await clearLocalData();
                    await context.read<AuthCubit>().logOut();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
          //bloc: context.read<DashboardCubit>()..loadDashboardData(),
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
            child: Text("No data found"),
          );
        }

        if (state is DashboardSuccess) {
          final count = state.dashboardModel.data;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Gap(12),
                        IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.amber,
                            ),
                            onPressed: () async {
                              await context.read<DashboardCubit>().loadDashboardData();
                            },
                            icon: Icon(
                              Icons.refresh,
                              size: 32,
                            )),
                        Gap(12),
                        Text(
                          'Refresh',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
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
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTicketCountsWidget(context, count!.totaltickets.toString(), 'Sales Quantity'),
                    _buildTicketCountsWidget(context, count.totalticketfare.toString(), 'Sales Amount'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTicketCountsWidget(context, count.totaladvancedtickets.toString(), 'Advance Quantity'),
                    _buildTicketCountsWidget(context, count.totaladvancedticketfare.toString(), 'Advance Amounts'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTicketCountsWidget(context, count.totalstudenttickets.toString(), 'Student Quantity'),
                    _buildTicketCountsWidget(context, count.totalstudentticketfare.toString(), 'Student Amounts'),
                  ],
                ),
                Gap(12),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Text(
                        '10 TK Ticket QTY: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${count.tenqty}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Text(
                        '15 TK Ticket QTY: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${count.fifteenqty}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Text(
                        '20 TK Ticket QTY: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${count.twentyqty}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Text(
                        '25 TK Ticket QTY: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${count.twentyfiveqty}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Text(
                        '40 TK Ticket QTY: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${count.fourtyqty}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Gap(12),
                Text(
                  'Device serial Number: ${storage.read('serialNumber')}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
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
                        '10ticketquantity': count.tenqty,
                        '15ticketquantity': count.fifteenqty,
                        '20ticketquantity': count.twentyqty,
                        '25ticketquantity': count.twentyfiveqty,
                        '40ticketquantity': count.fourtyqty,
                      };
                      await printTicketWithSunmi(ticketInfo: ticketInfo);
                    },
                    child: Text('Print Report')),
              ],
            ),
          );
        }
        return SizedBox.shrink();
      }),
    );
  }

  _buildTicketCountsWidget(BuildContext context, String count, String title) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      width: MediaQuery.of(context).size.width * .40,
      // height: MediaQuery.of(context).size.height * .12,
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
              fontSize: 20,
              color: ColorsPalate.onPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.28,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: ColorsPalate.onPrimaryColor,
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

      String userName = storage.read('name') ?? 'Unknown';
      String userId = storage.read('userName') ?? 'Unknown';
      String serialNumber = storage.read('serialNumber') ?? 'Unknown';
      String currentDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());

      // Print header
      await SunmiPrinter.printText(
        'HR Smart E-Tickets',
        style: SunmiTextStyle(
          bold: true,
          fontSize: 18,
          align: SunmiPrintAlign.CENTER,
        ),
      );
      await SunmiPrinter.lineWrap(1);
      await SunmiPrinter.printText('User: $userName');
      await SunmiPrinter.printText('ID: $userId');
      await SunmiPrinter.printText('Print Date: $currentDate');
      await SunmiPrinter.lineWrap(4);

      await SunmiPrinter.printText('Sales Log', style: SunmiTextStyle(bold: true, align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.lineWrap(1);

      // Print sales details
      await SunmiPrinter.printText('Sales Quantity: ${ticketInfo['totaltickets']}');
      await SunmiPrinter.printText('Sales Amount (BDT): ${ticketInfo['totalticketfare']}');
      await SunmiPrinter.printText('Advance Quantity: ${ticketInfo['totaladvancedtickets']}, Amounts : ${ticketInfo['totaladvancedticketfare']}');
      await SunmiPrinter.printText('Student Quantity: ${ticketInfo['totalstudenttickets']}, Amounts : ${ticketInfo['totalstudentticketfare']}');

      await SunmiPrinter.printText('10 TK Ticket QTY: ${ticketInfo['10ticketquantity']}');
      await SunmiPrinter.printText('15 TK Ticket QTY: ${ticketInfo['15ticketquantity']}');
      await SunmiPrinter.printText('20 TK Ticket QTY: ${ticketInfo['20ticketquantity']}');
      await SunmiPrinter.printText('25 TK Ticket QTY: ${ticketInfo['25ticketquantity']}');
      await SunmiPrinter.printText('40 TK Ticket QTY: ${ticketInfo['40ticketquantity']}');

      await SunmiPrinter.printText('-----------------', style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));

      // Print footer
      await SunmiPrinter.printText('Device Serial No: $serialNumber');
      await SunmiPrinter.lineWrap(2);

      await SunmiPrinter.printText('Thank you!',
          style: SunmiTextStyle(
            align: SunmiPrintAlign.CENTER,
          ));
      await SunmiPrinter.lineWrap(2);

      // Cut paper
      await SunmiPrinter.cutPaper();
    } catch (e) {
      debugPrint('Error while printing report: $e');
    }
  }
}
