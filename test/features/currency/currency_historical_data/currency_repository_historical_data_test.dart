import 'package:currency_converter/core/error/failures.dart';
// import 'package:currency_converter/core/flavor/flavor_config.dart';
// import 'package:currency_converter/core/network/network_info.dart';
// import 'package:currency_converter/features/currency/data/datasources/currency_local_datasource.dart';
// import 'package:currency_converter/features/currency/data/datasources/currency_remote_datasource.dart';
import 'package:currency_converter/features/currency/data/models/historical%20currency%20model/historical_currency_model.dart';
import 'package:currency_converter/features/currency/data/models/historical%20currency%20model/historical_currency_rate_model.dart';
import 'package:currency_converter/features/currency/domain/params/historical_currency_params.dart';
import 'package:dartz/dartz.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ntp/ntp.dart';
import 'package:test/test.dart';

import '../currency_test_helper.dart';

// // Generate mocks for the dependencies
// @GenerateMocks([
//   NTP,
// ])
void main() {
  final testSetup = TestSetup();

  setUp(() {
    testSetup.initialize();
  });

  group('getHistoricalCurrencyData', () {
    final params = HistoricalCurrencyParams(
      base: 'USD',
      currencies: 'EGP',
      // startDate: '2023-10-10',
      // endDate: '2023-10-10',
      // apiKey: 'TestAPIKeyForCurrency2347928xz3942h',
    );
    final tHistoricalCurrencyResponseEntity = HistoricalCurrencyResponseModel(
      success: true,
      base: 'USD',
      startDate: params.startDate ?? '2023-10-10',
      endDate: params.endDate ?? '2023-10-12',
      rates: const {
        '2023-10-10': {
          'EGP': 15.69,
        },
        '2023-10-11': {
          'EGP': 15.69,
        },
        '2023-10-12': {
          'EGP': 15.69,
        },
      },
    );

    test('should return data from remote data source when device is online',
        () async {
      // Arrange
      when(testSetup.mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      final tTime = DateTime(2023, 10, 10);
      when(testSetup.mockNTPService.now()).thenAnswer((_) async => tTime);
      when(testSetup.mockRemoteDataSource.getHistoricalData(any))
          .thenAnswer((_) async => tHistoricalCurrencyResponseEntity);
      when(testSetup.mockFlavorConfig.currencyApiKey)
          .thenReturn('TestAPIKeyForCurrency2347928xz3942h');

      // Act
      final result =
          await testSetup.repository.getHistoricalCurrencyData(params);

      // Assert
      verify(testSetup.mockNetworkInfo.isConnected);
      verify(testSetup.mockNTPService.now());
      verify(testSetup.mockRemoteDataSource.getHistoricalData(params));
      expect(result, Right(tHistoricalCurrencyResponseEntity));
    });

    test('should return data from local data source when device is offline',
        () async {
      // Arrange
      when(testSetup.mockNetworkInfo.isConnected)
          .thenAnswer((_) async => false);
      when(testSetup.mockLocalDataSource.getHistoricalData())
          .thenAnswer((_) async => tHistoricalCurrencyResponseEntity);

      // Act
      final result =
          await testSetup.repository.getHistoricalCurrencyData(params);

      // Assert
      verify(testSetup.mockNetworkInfo.isConnected);
      verify(testSetup.mockLocalDataSource.getHistoricalData());
      expect(result, Right(tHistoricalCurrencyResponseEntity));
    });

    test(
        'should return ServerFailure when there is an exception from remote data source',
        () async {
      // Arrange
      when(testSetup.mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      final tTime = DateTime(2023, 10, 10);
      when(testSetup.mockNTPService.now()).thenAnswer((_) async => tTime);
      when(testSetup.mockRemoteDataSource.getHistoricalData(any))
          .thenThrow(Exception());
      when(testSetup.mockFlavorConfig.currencyApiKey)
          .thenReturn('test_api_key');

      // Act
      final result =
          await testSetup.repository.getHistoricalCurrencyData(params);

      // Assert
      verify(testSetup.mockNetworkInfo.isConnected);
      verify(testSetup.mockNTPService.now());
      verify(testSetup.mockRemoteDataSource.getHistoricalData(params));
      expect(result, const Left(ServerFailure()));
    });

    test(
        'should return CacheFailure when there is an exception from local data source',
        () async {
      // Arrange
      when(testSetup.mockNetworkInfo.isConnected)
          .thenAnswer((_) async => false);
      when(testSetup.mockLocalDataSource.getHistoricalData())
          .thenThrow(Exception());

      // Act
      final result =
          await testSetup.repository.getHistoricalCurrencyData(params);

      // Assert
      verify(testSetup.mockNetworkInfo.isConnected);
      verify(testSetup.mockLocalDataSource.getHistoricalData());
      expect(result, const Left(CacheFailure()));
    });
  });
}
