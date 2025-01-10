import 'package:e_ticket/core/utils/colors_palate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../home/presentation/page/home_page.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return HomePage();
            }));
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('something went wrong')));
          }
        },
        builder: (context, state) {
          // if (state is AuthLoading) {
          //   return Center(child: CircularProgressIndicator());
          // }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 80,
                ),
                SizedBox(height: 50),
                CustomTextFormField(
                  controller: emailController,
                  hintText: 'Email',
                  borderDecoration: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                CustomTextFormField(
                  controller: passwordController,
                  hintText: 'Password',
                  borderDecoration: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16),
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
