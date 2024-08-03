import 'package:currency_converter/core/error/exceptions.dart';
import 'package:currency_converter/core/error/failures.dart';
// import 'package:currency_converter/core/flavor/flavor_config.dart';
// import 'package:currency_converter/core/network/network_info.dart';
// import 'package:currency_converter/features/currency/data/datasources/currency_local_datasource.dart';
// import 'package:currency_converter/features/currency/data/datasources/currency_remote_datasource.dart';
import 'package:currency_converter/features/currency/data/models/currency%20convert%20model/currency_convert_model.dart';
import 'package:currency_converter/features/currency/data/repositories/currency_repository_impl.dart';
import 'package:currency_converter/features/currency/domain/params/convert_currency_params.dart';
import 'package:dartz/dartz.dart';
// import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../currency_test_helper.dart';
import '../currency_test_helper.mocks.dart';

// // Generate mocks for the dependencies
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

  group('convertCurrency', () {
    final tParams = ConvertCurrencyParams(
      apiKey: 'TestAPIKeyForCurrency2347928xz3942h',
      amount: 1500,
      fromCurrency: 'USD',
      toCurrency: 'EGP',
      date: '2024-08-02',
    );
    final tCurrencyConvertEntity = CurrencyConvertResponseModel(
      success: true,
      info: CurrencyConvertInfoModel(timestamp: 1722556799, quote: 48.557705),
      query: CurrencyConvertQueryModel(amount: 1500, from: 'USD', to: 'EGP'),
      result: 72836.5575,
    );

    test('Should check network current state before calling remote', () async {
      await _testShouldCheckNetworkStateBeforeCallingRemote(
          testSetup.mockRemoteDataSource,
          testSetup.mockLocalDataSource,
          testSetup.mockNetworkInfo,
          testSetup.repository,
          tCurrencyConvertEntity,
          tParams);
    });

    group("Device is Connected to internet", () {
      setUp(() {
        when(testSetup.mockNetworkInfo.isConnected)
            .thenAnswer((_) async => true);
      });

      test(
          'Should return remote data when the call to remote data source is successful',
          () async {
        await _testShouldReturnRemoteDataWhenCallToRemoteDataSourceIsSuccessful(
            testSetup.mockRemoteDataSource,
            testSetup.repository,
            tCurrencyConvertEntity,
            tParams);
      });

      test(
        'Should call local data source when the call to remote data source is unsuccessful',
        () async {
          await _testShouldCallLocalDataSourceWhenCallToRemoteDataSourceIsUnsuccessful(
              testSetup.mockRemoteDataSource,
              testSetup.mockLocalDataSource,
              testSetup.repository,
              tCurrencyConvertEntity,
              tParams);
        },
      );

      test('should return server exception if server and cache failed',
          () async {
        await _testShouldReturnServerExceptionIfServerAndCacheFailed(
            testSetup.mockRemoteDataSource,
            testSetup.mockLocalDataSource,
            testSetup.repository,
            tParams);
      });
    });

    group("Device is not connected to internet", () {
      setUp(() {
        when(testSetup.mockNetworkInfo.isConnected)
            .thenAnswer((_) async => false);
      });

      test(
        'Should call local data source when the call to remote data source is unsuccessful',
        () async {
          await _testShouldCallLocalDataSourceWhenNoInternetConnection(
              testSetup.mockLocalDataSource,
              testSetup.repository,
              tCurrencyConvertEntity,
              tParams,
              testSetup.mockRemoteDataSource);
        },
      );

      test('should return network exception if server and cache failed',
          () async {
        await _testShouldReturnNetworkExceptionIfServerAndCacheFailed(
            testSetup.mockLocalDataSource, testSetup.repository, tParams);
      });
    });
  });
}

Future<void> _testShouldCheckNetworkStateBeforeCallingRemote(
    MockCurrencyRemoteDataSource mockRemoteDataSource,
    MockCurrencyLocalDataSource mockLocalDataSource,
    MockNetworkInfo mockNetworkInfo,
    CurrencyRepositoryImpl repository,
    CurrencyConvertResponseModel tCurrencyConvertEntity,
    ConvertCurrencyParams tParams) async {
  // arrange
  when(mockRemoteDataSource.convertCurrency(any))
      .thenAnswer((_) async => tCurrencyConvertEntity);
  when(mockLocalDataSource.getConvertCurrency(any))
      .thenAnswer((_) async => tCurrencyConvertEntity);
  when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
  // act
  repository.convertCurrency(tParams);
  // assert
  verify(mockNetworkInfo.isConnected);
}

Future<void> _testShouldReturnRemoteDataWhenCallToRemoteDataSourceIsSuccessful(
  MockCurrencyRemoteDataSource mockRemoteDataSource,
  CurrencyRepositoryImpl repository,
  CurrencyConvertResponseModel tCurrencyConvertEntity,
  ConvertCurrencyParams tParams,
) async {
  // arrange
  when(mockRemoteDataSource.convertCurrency(any))
      .thenAnswer((_) async => tCurrencyConvertEntity);
  // act
  final result = await repository.convertCurrency(tParams);
  // assert
  verify(mockRemoteDataSource.convertCurrency(tParams));
  expect(result, Right(tCurrencyConvertEntity));
}

Future<void>
    _testShouldCallLocalDataSourceWhenCallToRemoteDataSourceIsUnsuccessful(
  MockCurrencyRemoteDataSource mockRemoteDataSource,
  MockCurrencyLocalDataSource mockLocalDataSource,
  CurrencyRepositoryImpl repository,
  CurrencyConvertResponseModel tCurrencyConvertEntity,
  ConvertCurrencyParams tParams,
) async {
  // arrange
  when(mockRemoteDataSource.convertCurrency(any)).thenThrow(ServerException());
  when(mockLocalDataSource.getConvertCurrency(any))
      .thenAnswer((_) async => tCurrencyConvertEntity);
  // act
  final result = await repository.convertCurrency(tParams);
  // assert
  verify(mockRemoteDataSource.convertCurrency(tParams));
  verify(mockLocalDataSource.getConvertCurrency(tParams));
  expect(result, Right(tCurrencyConvertEntity));
}

Future<void> _testShouldReturnServerExceptionIfServerAndCacheFailed(
  MockCurrencyRemoteDataSource mockRemoteDataSource,
  MockCurrencyLocalDataSource mockLocalDataSource,
  CurrencyRepositoryImpl repository,
  ConvertCurrencyParams tParams,
) async {
  // arrange
  when(mockRemoteDataSource.convertCurrency(any)).thenThrow(ServerException());
  when(mockLocalDataSource.getConvertCurrency(any)).thenThrow(CacheException());
  // act
  final result = await repository.convertCurrency(tParams);
  // assert
  expect(result, const Left(ServerFailure()));
}

Future<void> _testShouldCallLocalDataSourceWhenNoInternetConnection(
    MockCurrencyLocalDataSource mockLocalDataSource,
    CurrencyRepositoryImpl repository,
    CurrencyConvertResponseModel tCurrencyConvertEntity,
    ConvertCurrencyParams tParams,
    MockCurrencyRemoteDataSource mockRemoteDataSource) async {
  // arrange
  when(mockLocalDataSource.getConvertCurrency(any))
      .thenAnswer((_) async => tCurrencyConvertEntity);
  // act
  final result = await repository.convertCurrency(tParams);
  // assert
  verifyNever(mockRemoteDataSource.convertCurrency(tParams));
  verify(mockLocalDataSource.getConvertCurrency(tParams));
  expect(result, Right(tCurrencyConvertEntity));
}

Future<void> _testShouldReturnNetworkExceptionIfServerAndCacheFailed(
  MockCurrencyLocalDataSource mockLocalDataSource,
  CurrencyRepositoryImpl repository,
  ConvertCurrencyParams tParams,
) async {
  // arrange
  when(mockLocalDataSource.getConvertCurrency(any)).thenThrow(CacheException());
  // act
  final result = await repository.convertCurrency(tParams);
  // assert
  expect(result, const Left(NetworkFailure()));
}
