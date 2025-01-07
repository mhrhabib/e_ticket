import 'package:e_ticket/app/di.dart';
import 'package:e_ticket/core/common/widgets/custom_dropdown.dart';
import 'package:e_ticket/core/common/widgets/custom_dropdown_shimmer.dart';
import 'package:e_ticket/core/utils/colors_palate.dart';
import 'package:e_ticket/modules/config/presentation/cubit/counter/counter_cubit.dart';
import 'package:e_ticket/modules/config/presentation/cubit/ticketRoutes/ticket_route_cubit.dart';
import 'package:e_ticket/modules/config/presentation/cubit/ticketRoutes/ticket_route_state.dart';
import 'package:e_ticket/modules/config/presentation/cubit/ticketType/ticket_type_cubit.dart';
import 'package:e_ticket/modules/config/presentation/cubit/user/user_cubit.dart';
import 'package:e_ticket/modules/counters/counters_list_page.dart';
import 'package:e_ticket/modules/profile/presentation/pages/profile_page.dart';
import 'package:e_ticket/modules/tickets/presentation/pages/tickets_sale_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              Icon(
                Icons.spa_outlined,
                size: 60,
                color: ColorsPalate.primaryColor,
              ),
              ListTile(
                leading: Icon(Icons.dashboard_outlined),
                title: Text(
                  'Ticket sale list',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => TicketsSaleListPage())),
              ),
              ListTile(
                leading: Icon(Icons.bus_alert),
                title: Text('Counters', style: TextStyle(fontSize: 18)),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CountersListPage())),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        spacing: 10,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 12),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('User'),
                Gap(2),
                Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                ),
              ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12),
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return const CustomDropdownShimmer();
                }
                if (state is UserFailUre) {
                  return const Text('No item');
                }
                if (state is UserSuccess) {
                  return CustomDropdown<String>(
                    value: state.selectedUser?.name, // Use selectedUser's name
                    items: state.users.map((user) => user.name).toList(),
                    onChanged: (selectedName) {
                      final selectedUser = state.users.firstWhere((user) => user.name == selectedName);
                      context.read<UserCubit>().selectUser(selectedUser); // Update selectedUser
                    },
                    hintText: 'name',
                    labelText: 'Select User',
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 12),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('Routes'),
                Gap(2),
                Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                ),
              ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12),
            child: BlocBuilder<TicketRouteCubit, TicketRouteState>(
              builder: (context, state) {
                if (state is TicketRouteLoading) {
                  return const CustomDropdownShimmer();
                }
                if (state is TicketRouteFailUre) {
                  return const Text('No item');
                }
                if (state is TicketRouteSuccess) {
                  return CustomDropdown<String>(
                    value: state.ticketRoute?.name, // Use selectedUser's name
                    items: state.ticketRoutes.map((user) => user.name!).toList(),
                    onChanged: (selectedName) {
                      final selectedRoute = state.ticketRoutes.firstWhere((user) => user.name == selectedName);
                      context.read<TicketRouteCubit>().selectRoute(selectedRoute); // Update selectedUser
                    },
                    hintText: 'name',
                    labelText: 'Select route',
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 12),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('To Ticket Counter'),
                Gap(2),
                Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                ),
              ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12),
            child: BlocBuilder<CounterCubit, CounterState>(
              bloc: CounterCubit(sl())..loadCounters(),
              builder: (context, state) {
                if (state is CounterLoading) {
                  return const CustomDropdownShimmer();
                }
                if (state is CounterFailure) {
                  return const Text('No item');
                }
                if (state is CounterSuccess) {
                  return CustomDropdown<String>(
                    value: state.counter?.name, // Use selectedUser's name
                    items: state.counters.map((user) => user.name!).toList(),
                    onChanged: (selectedName) {
                      final selectedRoute = state.counters.firstWhere((user) => user.name == selectedName);
                      context.read<CounterCubit>().selectCounter(selectedRoute); // Update selectedUser
                    },
                    hintText: 'name',
                    labelText: 'Select counter',
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 12),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('Type'),
                Gap(2),
                Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                ),
              ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12),
            child: BlocBuilder<TicketTypeCubit, TicketTypeState>(
              bloc: TicketTypeCubit(sl())..loadTicketTypes(),
              builder: (context, state) {
                if (state is TicketTypeLoading) {
                  return const CustomDropdownShimmer();
                }
                if (state is TicketTypeFailUre) {
                  return const Text('No item');
                }
                if (state is TicketTypeSuccess) {
                  return CustomDropdown<String>(
                    value: state.ticketType?.name, // Use selectedUser's name
                    items: state.ticketTypes.map((user) => user.name!).toList(),
                    onChanged: (selectedName) {
                      final selectedRoute = state.ticketTypes.firstWhere((user) => user.name == selectedName);
                      context.read<TicketTypeCubit>().selectType(selectedRoute); // Update selectedUser
                    },
                    hintText: 'name',
                    labelText: 'Select counter',
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Text('Price'),
          ),
        ],
      ),
    );
  }
}
