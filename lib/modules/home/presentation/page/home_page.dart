import 'package:e_ticket/core/common/helper/sale_service.dart';
import 'package:e_ticket/core/common/helper/storage.dart';
import 'package:e_ticket/core/utils/colors_palate.dart';
import 'package:e_ticket/modules/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:e_ticket/modules/profile/presentation/pages/profile_page.dart';
import 'package:e_ticket/modules/tickets/data/models/sale_model.dart';
import 'package:e_ticket/modules/tickets/presentation/cubit/ticket_sale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'widgets/build_ticket_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedRoute = 1; // Initially select Route-01
  final SaleService saleService = SaleService();
  String? selectedType;
  int? fromTicketCounterId;
  String? price;
  late Box<SaleModel> saleBox;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TicketSaleCubit>().loadTicketFareList();
    });
    saleBox = Hive.box<SaleModel>('sales');
    super.initState();
  }

  bool isAdvanced = false; // Tracks checkbox state
  String? selectedDate; // Stores the selected journey date

  bool isStudent = false; // To track whether the student fee is applied

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          final salesList = await saleService.getSalesFromHive();

          if (salesList.isNotEmpty) {
            await saleService.postSales(salesList);
          } else {
            print("Empty sale list **********************");
          }
        }
        if (mounted) {
          Future.microtask(() => context.read<DashboardCubit>().loadDashboardData());
        }
        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashboardScreen()));
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsPalate.primaryColor,
          title: Row(
            children: [
              Icon(Icons.location_on_outlined),
              Gap(8),
              Text(
                storage.read('fromCounterName').toString(),
                style: TextStyle(color: ColorsPalate.buttonFontColor),
              ),
            ],
          ),
          actions: [
            InkWell(
              onTap: () async {
                final SaleService saleService = SaleService();
                final salesList = await saleService.getSalesFromHive();
                if (salesList.isNotEmpty) {
                  await saleService.postSales(salesList);
                } else {
                  print("Empty sale list **********************");
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: Icon(
                Icons.account_circle_outlined,
                size: 30,
                color: ColorsPalate.buttonFontColor,
              ),
            ),
            Gap(12),
          ],
        ),
        body: BlocConsumer<TicketSaleCubit, TicketSaleState>(
          // bloc: TicketSaleCubit(ticketSaleUsecase: sl())..loadTicketFareList(),
          listener: (context, state) {
            if (state is TicketSaleSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Ticket sale successful!')),
              );
              // Trigger to reload the fare list
              context.read<TicketSaleCubit>().loadTicketFareList();
            }
          },
          builder: (context, state) {
            if (state is TicketSaleLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TicketSaleFailed) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is TicketFareSuccess) {
              final counters = state.ticketFareModel.prices;

              final route1 = counters!.where((e) => e.routeId == 1).toList();
              final route2 = counters.where((e) => e.routeId == 2).toList();

              return Column(
                children: [
                  Gap(8),
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Gap(4),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedRoute == 1 ? ColorsPalate.primaryColor : Colors.grey.shade300,
                            foregroundColor: selectedRoute == 1 ? Colors.white : Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              selectedRoute = 1;
                            });
                          },
                          child: Text('এফডিসি মোড় টু এফডিসি মোড়'),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedRoute == 2 ? ColorsPalate.primaryColor : Colors.grey.shade300,
                            foregroundColor: selectedRoute == 2 ? Colors.white : Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              selectedRoute = 2;
                            });
                          },
                          child: Text('শুটিং ক্লাব টু  শুটিং ক্লাব'),
                        ),
                        Gap(4),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       const Text('Student Fee', style: TextStyle(fontSize: 16)),
                        //       Checkbox(
                        //         value: isStudent,
                        //         onChanged: (value) {
                        //           setState(() {
                        //             isStudent = value!;
                        //           });
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text('Advanced', style: TextStyle(fontSize: 16)),
                            Gap(12),
                            Checkbox(
                              value: isAdvanced,
                              onChanged: (value) {
                                setState(() {
                                  isAdvanced = value!;
                                  if (isAdvanced) {
                                    // Set selectedDate to one month from today
                                    final today = DateTime.now();
                                    selectedDate = DateTime(today.year, today.month + 1, today.day).toIso8601String();
                                    print(selectedDate);
                                  } else {
                                    selectedDate = null; // Reset date if not advanced
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Student Fee', style: TextStyle(fontSize: 16)),
                            Checkbox(
                              value: isStudent,
                              onChanged: (value) {
                                setState(() {
                                  isStudent = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: selectedRoute == 1
                        ? buildTicketList(
                            context: context,
                            isAdvanced: isAdvanced,
                            isStudent: isStudent,
                            items: route1,
                            selectedDate: selectedDate,
                          )
                        : buildTicketList(
                            context: context,
                            isAdvanced: isAdvanced,
                            isStudent: isStudent,
                            items: route2,
                            selectedDate: selectedDate,
                          ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: saleBox.listenable(),
                    builder: (context, Box<SaleModel> box, _) {
                      int saleCount = box.length;
                      return Text(
                        "Current Sales: $saleCount",
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                      );
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsPalate.primaryColor,
                      foregroundColor: ColorsPalate.buttonFontColor,
                    ),
                    onPressed: () async {
                      final SaleService saleService = SaleService();
                      final salesList = await saleService.getSalesFromHive();
                      if (salesList.isNotEmpty) {
                        await saleService.postSales(salesList);
                      } else {
                        print("Empty sale list **********************");
                      }
                    },
                    child: Text('Submit to Server'),
                  ),
                  Gap(28),
                ],
              );
            }
            return Center(
              child: Text('data'),
            );
          },
        ),
      ),
    );
  }
}
