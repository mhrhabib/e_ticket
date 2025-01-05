import 'package:dio/dio.dart';
import 'package:e_ticket/core/utils/urls.dart';
import 'package:get_it/get_it.dart';
import '../modules/auth/data/datasources/auth_remote_data_source.dart';
import '../modules/auth/data/repositories/auth_repository_impl.dart';
import '../modules/auth/domain/repositories/auth_repository.dart';
import '../modules/auth/domain/usecases/login_use_case.dart';
import '../modules/auth/presentation/cubit/auth_cubit.dart';
import '../modules/splash/presentation/cubit/splash_cubit.dart';

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
}
