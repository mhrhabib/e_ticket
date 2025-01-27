import 'package:e_ticket/app/di.dart';
import 'package:e_ticket/modules/config/presentation/cubit/counter/counter_cubit.dart';
import 'package:e_ticket/modules/config/presentation/cubit/ticketPrice/ticket_price_cubit.dart';
import 'package:e_ticket/modules/config/presentation/cubit/ticketRoutes/ticket_route_cubit.dart';
import 'package:e_ticket/modules/config/presentation/cubit/ticketType/ticket_type_cubit.dart';
import 'package:e_ticket/modules/config/presentation/cubit/user/user_cubit.dart';
import 'package:e_ticket/modules/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:e_ticket/modules/profile/presentation/cubit/profile_cubit.dart';
import 'package:e_ticket/modules/tickets/presentation/cubit/ticket_sale_cubit.dart';
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
        BlocProvider(create: (context) => sl<SplashCubit>()..initializeApp()),
        BlocProvider(create: (context) => sl<AuthCubit>()),
        BlocProvider(create: (context) => sl<CounterCubit>()),
        BlocProvider(create: (context) => sl<UserCubit>()..loadUsers()),
        BlocProvider(create: (context) => sl<TicketTypeCubit>()..loadTicketTypes()),
        BlocProvider(create: (context) => sl<TicketRouteCubit>()..loadTicketRoutes()),
        BlocProvider(create: (context) => sl<ProfileCubit>()..loadProfilesData()),
        BlocProvider(create: (context) => sl<TicketSaleCubit>()..loadTicketFareList()),
        BlocProvider(create: (context) => sl<TicketPriceCubit>()),
        BlocProvider(create: (context) => sl<DashboardCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HR Smart E-Tickets',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.white),
            )),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          '/login': (context) => LoginPage(),
        },
      ),
    );
  }
}
