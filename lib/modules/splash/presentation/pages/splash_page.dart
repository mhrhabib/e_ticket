import 'package:e_ticket/core/common/helper/storage.dart';
import 'package:e_ticket/modules/auth/presentation/pages/login_page.dart';
import 'package:e_ticket/modules/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/splash_cubit.dart';
import '../cubit/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashSuccess) {
          // Navigate to login page
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
            return storage.read('token') != null ? DashboardScreen() : LoginPage();
          }));
        } else if (state is SplashFailure) {
          // Handle failure, e.g., show a dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text(state.errorMessage),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
      },
      child: Scaffold(
        body: Center(
            child: Image.asset(
          'assets/logo.png',
          height: 80,
        )),
      ),
    );
  }
}
