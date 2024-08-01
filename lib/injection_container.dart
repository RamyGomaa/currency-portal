import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';

import 'core/api/api_consumer.dart';
import 'core/api/api_interceptor.dart';
import 'core/api/dio_consumer.dart';
import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
//!bloc

  // sl.registerFactory(() => Bloc(sl()));

//!usecases

  // sl.registerLazySingleton(() => UseCase(sl()));

//!repositories
  // sl.registerLazySingleton<Repository>(
  //   () => RepositoryImpl(
  //     networkInfo: sl(),
  //     remoteDataSource: sl(),
  //     localDataSource: sl(),
  //   ),
  // );

//!data sources
  // sl.registerLazySingleton<LocalDataSouce>(
  //     () => LocalDataSouceImpl(hive: sl()));
  // sl.registerLazySingleton<RemoteDataSouce>(
  //     () => RemoteDataSouceImpl(client: sl()));

//!core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//!external
  final appDocumentDirectory =
      await getApplicationDocumentsDirectory(); // from path_provider package
  sl.registerSingletonAsync<HiveInterface>(() async {
    Hive.init(appDocumentDirectory.path);
    // Hive.registerAdapter(Adapter());

    return Hive;
  });

  sl.registerLazySingleton(() => ApiInterceptor(
      // authRepository: sl(),
      ));

  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));

  sl.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.interceptors.add(sl<ApiInterceptor>());

    return dio;
  });
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
