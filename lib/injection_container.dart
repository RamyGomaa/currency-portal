import 'package:currency_converter/core/flavor/flavor_config.dart';
import 'package:currency_converter/features/currency/data/datasources/currency_local_datasource.dart';
import 'package:currency_converter/features/currency/data/datasources/currency_remote_datasource.dart';
import 'package:currency_converter/features/currency/data/repositories/currency_repository_impl.dart';
import 'package:currency_converter/features/currency/domain/repositories/currency_repository.dart';
import 'package:currency_converter/features/currency/domain/usecases/convert_currency_usecase.dart';
import 'package:currency_converter/features/currency/domain/usecases/get_currency_list_usecase.dart';
import 'package:currency_converter/features/currency/domain/usecases/get_historical_currency.dart';
import 'package:currency_converter/features/currency/presentation/bloc/currency_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';

import 'core/api/api_consumer.dart';
import 'core/api/api_interceptor.dart';
import 'core/api/dio_consumer.dart';
import 'core/constants/constants.dart';
import 'core/network/network_info.dart';
import 'features/currency/data/models/currency model/currency_model.dart';

final sl = GetIt.instance;

Future<void> init() async {
//!bloc

  sl.registerFactory(() => CurrencyBloc(sl(), sl(), sl()));

//!usecases

  sl.registerLazySingleton(() => GetCurrencyListUsecase(sl()));
  sl.registerLazySingleton(() => ConvertCurrencyUsecase(sl()));
  sl.registerLazySingleton(() => GetHistoricalCurrencyUseCase(sl()));

//!repositories
  sl.registerLazySingleton<CurrencyRepository>(
    () => CurrencyRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

//!data sources
  sl.registerLazySingleton<CurrencyLocalDataSource>(
      () => CurrencyLocalDataSourceImpl(hive: sl()));
  sl.registerLazySingleton<CurrencyRemoteDataSource>(
    () => CurrencyRemoteDataSourceImpl(
      sl<Dio>(),
      // baseUrl: FlavorConfig.instance.currencyBaseUrl,
    ),
  );

//!core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//!external
  final appDocumentDirectory =
      await getApplicationDocumentsDirectory(); // from path_provider package
  sl.registerSingletonAsync<HiveInterface>(() async {
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(CurrencyResponseModelAdapter());
    Hive.registerAdapter(CurrencyResponseDataModelAdapter());

    return Hive;
  });

  sl.registerLazySingleton(() => ApiInterceptor(
      // authRepository: sl(),
      ));

  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));

  sl.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.interceptors.add(sl<ApiInterceptor>());
    dio.options.baseUrl = FlavorConfig.instance.currencyBaseUrl;
    dio.options.connectTimeout =
        const Duration(seconds: Constants.networkTimeout);
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
    return dio;
  });
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
