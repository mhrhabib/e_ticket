import 'package:dio/dio.dart';
import 'package:e_ticket/core/utils/urls.dart';
import 'package:e_ticket/modules/config/data/datasources/config_remote_data_source.dart';
import 'package:e_ticket/modules/config/data/repository/counter_repository_impl.dart';
import 'package:e_ticket/modules/config/data/repository/ticket_price_repository_impl.dart';
import 'package:e_ticket/modules/config/data/repository/ticket_routes_repository_impl.dart';
import 'package:e_ticket/modules/config/data/repository/ticket_type_repository_impl.dart';
import 'package:e_ticket/modules/config/domain/repository/counter_repository.dart';
import 'package:e_ticket/modules/config/domain/repository/ticket_routes_repository.dart';
import 'package:e_ticket/modules/config/domain/repository/ticket_type_repository.dart';
import 'package:e_ticket/modules/config/domain/usecases/calculate_ticket_price_usecase.dart';
import 'package:e_ticket/modules/config/domain/usecases/get_counters_usecase.dart';
import 'package:e_ticket/modules/config/domain/usecases/get_ticket_routes_usecase.dart';
import 'package:e_ticket/modules/config/domain/usecases/get_ticket_type_usecase.dart';
import 'package:e_ticket/modules/config/presentation/cubit/counter/counter_cubit.dart';
import 'package:e_ticket/modules/config/presentation/cubit/ticketPrice/ticket_price_cubit.dart';
import 'package:e_ticket/modules/config/presentation/cubit/ticketRoutes/ticket_route_cubit.dart';
import 'package:e_ticket/modules/config/presentation/cubit/ticketType/ticket_type_cubit.dart';
import 'package:e_ticket/modules/profile/data/datasource/profile_remote_data_source.dart';
import 'package:e_ticket/modules/profile/data/repository/profile_repository_impl.dart';
import 'package:e_ticket/modules/profile/domain/repository/profile_repository.dart';
import 'package:e_ticket/modules/profile/domain/usecases/get_porfile_use_case.dart';
import 'package:e_ticket/modules/tickets/data/datasource/ticket_remote_data_source.dart';
import 'package:e_ticket/modules/tickets/domain/repository/ticket_sale_repository.dart';
import 'package:e_ticket/modules/tickets/domain/usecase/ticket_sale_usecase.dart';
import 'package:e_ticket/modules/tickets/presentation/cubit/ticket_sale_cubit.dart';
import 'package:get_it/get_it.dart';
import '../modules/auth/data/datasources/auth_remote_data_source.dart';
import '../modules/auth/data/repositories/auth_repository_impl.dart';
import '../modules/auth/domain/repositories/auth_repository.dart';
import '../modules/auth/domain/usecases/login_use_case.dart';
import '../modules/auth/presentation/cubit/auth_cubit.dart';
import '../modules/config/data/repository/user_repository_impl.dart';
import '../modules/config/domain/repository/ticket_price_repository.dart';
import '../modules/config/domain/repository/user_repositoy.dart';
import '../modules/config/domain/usecases/get_user_usecase.dart';
import '../modules/config/presentation/cubit/user/user_cubit.dart';
import '../modules/profile/presentation/cubit/profile_cubit.dart';
import '../modules/splash/presentation/cubit/splash_cubit.dart';
import '../modules/tickets/data/repository/tickets_repository_impl.dart';

final sl = GetIt.instance;

void setup() {
  // Network
  sl.registerLazySingleton(() => Dio(BaseOptions(baseUrl: Urls.baseUrl)));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));

  // Cubits
  sl.registerFactory(() => AuthCubit(loginUseCase: sl()));
  sl.registerFactory(() => SplashCubit());

  //configs
  sl.registerLazySingleton<ConfigRemoteDataSource>(
    () => ConfigRemoteDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<CounterRepository>(() => CounterRepositoryImpl(sl()));
  sl.registerLazySingleton<TicketRoutesRepository>(() => TicketRoutesRepositoryImpl(configRemoteDataSource: sl()));
  sl.registerLazySingleton<TicketTypesRepository>(() => TicketTypeRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetUsersUseCase(sl()));
  sl.registerLazySingleton(() => GetCountersUsecase(sl()));
  sl.registerLazySingleton(() => GetTicketTypeUsecase(sl()));
  sl.registerLazySingleton(() => GetTicketRoutesUsecase(sl()));

  // Cubits
  sl.registerFactory(() => UserCubit(getUsersUseCase: sl()));
  sl.registerFactory(() => TicketTypeCubit(sl()));
  sl.registerFactory(() => TicketRouteCubit(sl()));
  sl.registerFactory(() => CounterCubit(sl()));
  // profile
  sl.registerLazySingleton<ProfileRemoteDataSource>(() => ProfileRemoteDataSourceImpl());
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerFactory(() => ProfileCubit(getProfileUseCase: sl()));

  //ticket sale
  sl.registerLazySingleton<TicketRemoteDataSource>(() => TicketRemoteDataSourceImpl());
  sl.registerLazySingleton<TicketSaleRepository>(() => TicketsRepositoryImpl(sl()));
  sl.registerLazySingleton(() => TicketSaleUsecase(sl()));
  sl.registerFactory(() => TicketSaleCubit(ticketSaleUsecase: sl()));

  //ticket price
  // Repository
  sl.registerLazySingleton<TicketPriceRepository>(() => TicketPriceRepositoryImpl(sl()));
  // Use case
  sl.registerLazySingleton(() => CalculateTicketPriceUseCase(sl()));
  // Cubit
  sl.registerFactory(() => TicketPriceCubit(sl()));
}
