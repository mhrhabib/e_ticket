import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ashiqur rahman'),
        actions: [
          Icon(
            Icons.account_circle_outlined,
            size: 30,
          ),
          Gap(12),
        ],
      ),
      drawer: Drawer(),
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}
