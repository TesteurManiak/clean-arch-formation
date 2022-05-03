import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/local_datasource.dart';
import '../../data/datasources/remote_datasource.dart';
import '../platform/http_client.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  _setupDomain();
  await _setupData();
  _setupCore();
}

void _setupDomain() {}

Future<void> _setupData() async {
  final sp = await SharedPreferences.getInstance();

  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(sharedPreferences: sp),
  );
}

void _setupCore() {
  sl.registerLazySingleton<HttpClient>(() => DioClient(dio: Dio()));
}
