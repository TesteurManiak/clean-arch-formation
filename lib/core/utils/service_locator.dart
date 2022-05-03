import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/local_datasource.dart';
import '../../data/datasources/remote_datasource.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/get_random_user.dart';
import '../platform/http_client.dart';
import '../platform/network_info.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  _setupDomain();
  await _setupData();
  _setupCore();
}

void _setupDomain() {
  //! Use cases
  sl.registerLazySingleton(() => GetRandomUser(sl()));
}

Future<void> _setupData() async {
  final sp = await SharedPreferences.getInstance();

  //! Repositories
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //! Data sources
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(sharedPreferences: sp),
  );
}

void _setupCore() {
  //! External services
  sl.registerLazySingleton<HttpClient>(() => DioClient(Dio()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(Connectivity()));
}
