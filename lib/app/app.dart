import 'package:e_ticket/app/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/auth/presentation/cubit/auth_cubit.dart';
import '../modules/auth/presentation/pages/login_page.dart';
import '../modules/splash/presentation/cubit/splash_cubit.dart';
import '../modules/splash/presentation/pages/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<SplashCubit>()..initializeApp(),
        ),
        BlocProvider(
          create: (context) => sl<AuthCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          '/login': (context) => LoginPage(),
        },
      ),
    );
  }
}
