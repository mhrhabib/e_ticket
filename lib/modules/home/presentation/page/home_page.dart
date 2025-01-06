import 'package:e_ticket/core/utils/colors_palate.dart';
import 'package:e_ticket/modules/counters/counters_list_page.dart';
import 'package:e_ticket/modules/profile/presentation/pages/profile_page.dart';
import 'package:e_ticket/modules/tickets/presentation/pages/tickets_sale_list_page.dart';
import 'package:flutter/material.dart';
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
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}
