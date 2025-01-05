import 'package:e_ticket/core/common/helper/storage.dart';
import 'package:e_ticket/modules/auth/presentation/pages/login_page.dart';
import 'package:e_ticket/modules/home/presentation/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_ticket/core/utils/colors_palate.dart';

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
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return storage.read('token') != null ? HomePage() : LoginPage();
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
          child: Icon(
            Icons.spa,
            color: ColorsPalate.primaryColor,
            size: 60,
          ),
        ),
      ),
    );
  }
}
