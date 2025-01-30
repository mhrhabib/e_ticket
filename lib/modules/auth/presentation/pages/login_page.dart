import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../../core/utils/colors_palate.dart';
import '../../../dashboard/presentation/screens/dashboard_screen.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return DashboardScreen();
            }));
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Something went wrong')),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'HR Smart E-Tickets',
                  style: TextStyle(fontSize: 22),
                ),
                const Gap(12),
                Image.asset(
                  'assets/logo.png',
                  height: 80,
                ),
                const SizedBox(height: 50),
                CustomTextFormField(
                  controller: emailController,
                  hintText: 'Identifiers',
                  borderDecoration: OutlineInputBorder(
                    borderSide: const BorderSide(),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Gap(12),
                ValueListenableBuilder<bool>(
                  valueListenable: isPasswordVisible,
                  builder: (context, value, child) {
                    return CustomTextFormField(
                      controller: passwordController,
                      hintText: 'Password',
                      borderDecoration: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffix: IconButton(
                        icon: Icon(value ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          isPasswordVisible.value = !isPasswordVisible.value;
                        },
                      ),
                      obscureText: !value,
                    );
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsPalate.primaryColor,
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.80, 50),
                  ),
                  onPressed: () {
                    context.read<AuthCubit>().login(
                          emailController.text,
                          passwordController.text,
                        );
                  },
                  child: Text(
                    state is AuthLoading ? 'Loading.....' : 'Login',
                    style: TextStyle(
                      color: ColorsPalate.buttonFontColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
