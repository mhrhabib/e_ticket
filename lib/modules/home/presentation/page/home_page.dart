import 'package:e_ticket/core/utils/colors_palate.dart';
import 'package:e_ticket/modules/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_ticket/modules/auth/presentation/pages/login_page.dart';
import 'package:e_ticket/modules/profile/presentation/pages/profile_page.dart';
import 'package:e_ticket/modules/tickets/presentation/cubit/ticket_sale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'widgets/build_ticket_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedRoute = 1; // Initially select Route-01

  int? selectedUserId;
  int? selectedRouteId;
  int? selectedCounterId;
  String? selectedType;
  int? fromTicketCounterId;
  String? price;

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<TicketSaleCubit>().loadTicketFareList();
    // });

    super.initState();
  }

  bool isAdvanced = false; // Tracks checkbox state
  String? selectedDate; // Stores the selected journey date

  // Method to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  bool isStudent = false; // To track whether the student fee is applied

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsPalate.primaryColor,
        title: Text(
          'ashiqur rahman',
          style: TextStyle(color: ColorsPalate.onPrimaryColor),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            child: Icon(
              Icons.account_circle_outlined,
              size: 30,
              color: ColorsPalate.onPrimaryColor,
            ),
          ),
          Gap(12),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            spacing: 20,
            children: [
              Image.asset(
                'assets/logo.png',
                height: 50,
              ),
              // ListTile(
              //   leading: Icon(Icons.dashboard_outlined),
              //   title: Text(
              //     'Ticket sale list',
              //     style: TextStyle(fontSize: 18),
              //   ),
              //   onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => TicketsSaleListPage())),
              // ),
              // ListTile(
              //   leading: Icon(Icons.bus_alert),
              //   title: Text('Counters', style: TextStyle(fontSize: 18)),
              //   onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CountersListPage())),
              // ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('LogOut', style: TextStyle(fontSize: 18)),
                onTap: () {
                  context.read<AuthCubit>().logOut().then((_) {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (login) {
                      return true;
                    });
                  });
                },
              ),
            ],
          ),
        ),
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
              spacing: 10,
              children: [
                Gap(8),
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gap(8),
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
                        child: Text('Route-01'),
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
                        child: Text('Route-02'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Advanced', style: TextStyle(fontSize: 16)),
                      Checkbox(
                        value: isAdvanced,
                        onChanged: (value) {
                          setState(() {
                            isAdvanced = value!;
                            if (!isAdvanced) {
                              selectedDate = null; // Reset date if not advanced
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                if (isAdvanced)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedDate ?? 'Select Journey Date',
                          style: TextStyle(
                            fontSize: 16,
                            color: selectedDate == null ? Colors.grey : Colors.black,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsPalate.secondaryColor,
                            foregroundColor: ColorsPalate.onPrimaryColor,
                          ),
                          onPressed: () => _selectDate(context),
                          child: const Text('Pick Date'),
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
              ],
            );
          }
          return Center(
            child: Text('data'),
          );
        },
      ),
    );
  }
}
