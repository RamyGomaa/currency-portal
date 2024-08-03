// test_helpers.dart
import 'package:currency_converter/core/flavor/flavor_config.dart';
import 'package:currency_converter/core/network/network_info.dart';
import 'package:currency_converter/features/currency/data/datasources/currency_local_datasource.dart';
import 'package:currency_converter/features/currency/data/datasources/currency_remote_datasource.dart';
import 'package:currency_converter/features/currency/data/repositories/currency_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'currency_test_helper.mocks.dart';

@GenerateMocks([
  CurrencyRemoteDataSource,
  CurrencyLocalDataSource,
  NetworkInfo,
  FlavorConfig
])
class TestSetup {
  late CurrencyRepositoryImpl repository;
  late MockCurrencyRemoteDataSource mockRemoteDataSource;
  late MockCurrencyLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockFlavorConfig mockFlavorConfig;

  void initialize() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockRemoteDataSource = MockCurrencyRemoteDataSource();
    mockLocalDataSource = MockCurrencyLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockFlavorConfig = MockFlavorConfig();
    repository = CurrencyRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
      flavorConfig: mockFlavorConfig,
    );
  }
}
