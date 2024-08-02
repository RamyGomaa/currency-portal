import 'package:currency_converter/core/constants/constants.dart';
import 'package:currency_converter/core/constants/end_points.dart';
import 'package:currency_converter/core/error/exceptions.dart';
import 'package:currency_converter/core/error/failures.dart';
import 'package:currency_converter/core/network/network_info.dart';
import 'package:currency_converter/features/currency/data/datasources/currency_local_datasource.dart';
import 'package:currency_converter/features/currency/data/datasources/currency_remote_datasource.dart';
import 'package:currency_converter/features/currency/data/models/currency%20convert%20model/currency_convert_model.dart';
import 'package:currency_converter/features/currency/data/repositories/currency_repository_impl.dart';
import 'package:currency_converter/features/currency/domain/params/convert_currency_params.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'currency_repository_impl_test.mocks.dart';

// Generate mocks for the dependencies
@GenerateMocks([CurrencyRemoteDataSource, CurrencyLocalDataSource, NetworkInfo])
void main() {
  late CurrencyRepositoryImpl repository;
  late MockCurrencyRemoteDataSource mockRemoteDataSource;
  late MockCurrencyLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockCurrencyRemoteDataSource();
    mockLocalDataSource = MockCurrencyLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CurrencyRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
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
    });

    group("Device is Connected to internet", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'Should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.convertCurrency(any))
            .thenAnswer((_) async => tCurrencyConvertEntity);
        // act
        final result = await repository.convertCurrency(tParams);
        // assert
        verify(mockRemoteDataSource.convertCurrency(tParams));
        expect(result, Right(tCurrencyConvertEntity));
      });
      test(
        'Should call local data source when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.convertCurrency(any))
              .thenThrow(ServerException());
          when(mockLocalDataSource.getConvertCurrency(any))
              .thenAnswer((_) async => tCurrencyConvertEntity);

          // act
          final result = await repository.convertCurrency(tParams);

          // assert
          verify(mockRemoteDataSource.convertCurrency(tParams));
          verify(mockLocalDataSource.getConvertCurrency(tParams));
          expect(result, Right(tCurrencyConvertEntity));
        },
      );

      test('should return server exeption if server and cache failed',
          () async {
        // arrange
        when(mockRemoteDataSource.convertCurrency(any))
            .thenThrow(ServerException());
        when(mockLocalDataSource.getConvertCurrency(any))
            .thenThrow(CacheException());
        // act
        final result = await repository.convertCurrency(tParams);
        // assert
        expect(result, const Left(ServerFailure()));
      });
    });

    group("Device is not connected to internet", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'Should call local data source when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockLocalDataSource.getConvertCurrency(any))
              .thenAnswer((_) async => tCurrencyConvertEntity);

          // act
          final result = await repository.convertCurrency(tParams);

          // assert
          verifyNever(mockRemoteDataSource.convertCurrency(tParams));
          verify(mockLocalDataSource.getConvertCurrency(tParams));
          expect(result, Right(tCurrencyConvertEntity));
        },
      );

      test('should return network exeption if server and cache failed',
          () async {
        // arrange
        when(mockLocalDataSource.getConvertCurrency(any))
            .thenThrow(CacheException());
        // act
        final result = await repository.convertCurrency(tParams);
        // assert
        expect(result, const Left(NetworkFailure()));
      });
    });

    //api testing for the convert currency
    group(
      'Currency Convert API test',
      () {
        setUp(
          () {
            Dio dio = Dio();
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
            repository = CurrencyRepositoryImpl(
              remoteDataSource: CurrencyRemoteDataSourceImpl(
                dio,
                // baseUrl: EndPoint.devBaseUrl,
              ),
              localDataSource: mockLocalDataSource,
              networkInfo: NetworkInfoImpl(
                InternetConnectionChecker(),
              ),
            );
          },
        );

        test(
          'Should return CurrencyConvertResponseEntity when the call to remote data source is successful',
          () async {
            // arrange
            when(mockLocalDataSource.getConvertCurrency(tParams))
                .thenAnswer((_) async => tCurrencyConvertEntity);
            // act
            final result = await repository.convertCurrency(tParams);
            // assert
            verifyNever(mockLocalDataSource.getConvertCurrency(tParams));
            verify(mockRemoteDataSource.convertCurrency(tParams));
            expect(result, isA<Right>());
          },
        );
      },
    );
  });
}
