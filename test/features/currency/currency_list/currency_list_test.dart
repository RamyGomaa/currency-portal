// import 'package:currency_converter/core/flavor/flavor_config.dart';
// import 'package:currency_converter/core/network/network_info.dart';
// import 'package:currency_converter/features/currency/data/datasources/currency_local_datasource.dart';
// import 'package:currency_converter/features/currency/data/datasources/currency_remote_datasource.dart';
import 'package:currency_converter/features/currency/data/repositories/currency_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
import 'package:currency_converter/features/currency/data/models/currency%20model/currency_model.dart';
import 'package:dartz/dartz.dart';
import 'package:currency_converter/core/error/exceptions.dart';
import 'package:currency_converter/core/error/failures.dart';
import 'package:mockito/mockito.dart';
import '../currency_test_helper.dart';
import '../currency_test_helper.mocks.dart';

// @GenerateMocks([
//   CurrencyRemoteDataSource,
//   CurrencyLocalDataSource,
//   NetworkInfo,
//   FlavorConfig
// ])
void main() {
  final testSetup = TestSetup();

  setUp(() {
    testSetup.initialize();
  });

  group('getCurrencyList', () {
    final tCurrencyResponseEntity = CurrencyResponseModel(
      symbols: [
        CurrencyResponseDataModel(
            currencyCode: 'USD', currencyName: 'US Dollar'),
        CurrencyResponseDataModel(
            currencyCode: 'EGP', currencyName: 'Egyptian Pound'),
        CurrencyResponseDataModel(currencyCode: 'EUR', currencyName: 'Euro'),
        CurrencyResponseDataModel(
            currencyCode: 'JPY', currencyName: 'Japanese Yen'),
        CurrencyResponseDataModel(
            currencyCode: 'GBP', currencyName: 'British Pound'),
        CurrencyResponseDataModel(
            currencyCode: 'AUD', currencyName: 'Australian Dollar'),
        CurrencyResponseDataModel(
            currencyCode: 'CAD', currencyName: 'Canadian Dollar'),
      ],
      success: true,
    );

    // const tJsonString =
    //     '[{"code": "USD", "countryCode": "us", "flag": "base64flag"}]';

    test('should return local data when available', () async {
      await _testShouldReturnLocalDataWhenAvailable(
          testSetup.mockLocalDataSource,
          testSetup.repository,
          tCurrencyResponseEntity,
          testSetup.mockNetworkInfo,
          testSetup.mockRemoteDataSource);
    });

    test(
        'should fetch remote data when local data is not available and internet is connected',
        () async {
      await _testShouldFetchRemoteDataWhenLocalDataNotAvailableAndInternetConnected(
          testSetup.mockLocalDataSource,
          testSetup.mockNetworkInfo,
          testSetup.mockRemoteDataSource,
          testSetup.mockFlavorConfig,
          testSetup.repository,
          tCurrencyResponseEntity);
    });

    test('should return ServerFailure when remote data fetch fails', () async {
      await _testShouldReturnServerFailureWhenRemoteDataFetchFails(
          testSetup.mockLocalDataSource,
          testSetup.mockNetworkInfo,
          testSetup.mockRemoteDataSource,
          testSetup.mockFlavorConfig,
          testSetup.repository);
    });

    test('should return NetworkFailure when there is no internet connection',
        () async {
      await _testShouldReturnNetworkFailureWhenNoInternetConnection(
          testSetup.mockLocalDataSource,
          testSetup.mockNetworkInfo,
          testSetup.repository);
    });
  });
}

Future<void> _testShouldReturnLocalDataWhenAvailable(
  MockCurrencyLocalDataSource mockLocalDataSource,
  CurrencyRepositoryImpl repository,
  CurrencyResponseModel tCurrencyResponseEntity,
  MockNetworkInfo mockNetworkInfo,
  MockCurrencyRemoteDataSource mockRemoteDataSource,
) async {
  // arrange
  when(mockLocalDataSource.getCurrencyList())
      .thenAnswer((_) async => tCurrencyResponseEntity);
  // act
  final result = await repository.getCurrencyList();
  // assert
  verify(mockLocalDataSource.getCurrencyList());
  verifyNever(mockNetworkInfo.isConnected);
  verifyNever(mockRemoteDataSource.getCurrencyList(any));
  expect(result, equals(Right(tCurrencyResponseEntity)));
}

Future<void>
    _testShouldFetchRemoteDataWhenLocalDataNotAvailableAndInternetConnected(
  MockCurrencyLocalDataSource mockLocalDataSource,
  MockNetworkInfo mockNetworkInfo,
  MockCurrencyRemoteDataSource mockRemoteDataSource,
  MockFlavorConfig mockFlavorConfig,
  CurrencyRepositoryImpl repository,
  CurrencyResponseModel tCurrencyResponseEntity,
) async {
  // arrange
  when(mockLocalDataSource.getCurrencyList()).thenThrow(CacheException());
  when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
  when(mockRemoteDataSource.getCurrencyList(any))
      .thenAnswer((_) async => tCurrencyResponseEntity);
  when(mockFlavorConfig.currencyApiKey).thenReturn('TestAPIKeyForCurrency');
  // act
  final result = await repository.getCurrencyList();
  // assert
  verify(mockLocalDataSource.getCurrencyList());
  verify(mockNetworkInfo.isConnected);
  verify(mockRemoteDataSource.getCurrencyList(any));
  expect(result, equals(Right(tCurrencyResponseEntity)));
}

Future<void> _testShouldReturnServerFailureWhenRemoteDataFetchFails(
  MockCurrencyLocalDataSource mockLocalDataSource,
  MockNetworkInfo mockNetworkInfo,
  MockCurrencyRemoteDataSource mockRemoteDataSource,
  MockFlavorConfig mockFlavorConfig,
  CurrencyRepositoryImpl repository,
) async {
  // arrange
  when(mockLocalDataSource.getCurrencyList()).thenThrow(CacheException());
  when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
  when(mockRemoteDataSource.getCurrencyList(any)).thenThrow(ServerException());
  when(mockFlavorConfig.currencyApiKey).thenReturn('TestAPIKeyForCurrency');
  // act
  final result = await repository.getCurrencyList();
  // assert
  verify(mockLocalDataSource.getCurrencyList());
  verify(mockNetworkInfo.isConnected);
  verify(mockRemoteDataSource.getCurrencyList(any));
  expect(result, equals(const Left(ServerFailure())));
}

Future<void> _testShouldReturnNetworkFailureWhenNoInternetConnection(
  MockCurrencyLocalDataSource mockLocalDataSource,
  MockNetworkInfo mockNetworkInfo,
  CurrencyRepositoryImpl repository,
) async {
  // arrange
  when(mockLocalDataSource.getCurrencyList()).thenThrow(CacheException());
  when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
  // act
  final result = await repository.getCurrencyList();
  // assert
  verify(mockLocalDataSource.getCurrencyList());
  verify(mockNetworkInfo.isConnected);
  expect(result, equals(const Left(NetworkFailure())));
}
