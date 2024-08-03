import 'dart:convert';

import 'package:currency_converter/core/constants/constants.dart';
import 'package:currency_converter/core/error/exceptions.dart';
import 'package:currency_converter/core/error/failures.dart';
import 'package:currency_converter/core/flavor/flavor_config.dart';
import 'package:currency_converter/core/network/network_info.dart';
import 'package:currency_converter/features/currency/domain/entities/currency_entity.dart';
import 'package:currency_converter/features/currency/domain/entities/currrency_convert_entity.dart';
import 'package:currency_converter/features/currency/domain/entities/historical_currency_entity.dart';
import 'package:currency_converter/features/currency/domain/params/convert_currency_params.dart';
import 'package:currency_converter/features/currency/domain/params/historical_currency_params.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../domain/repositories/currency_repository.dart';
import '../datasources/currency_local_datasource.dart';
import '../datasources/currency_remote_datasource.dart';

class CurrencyRepositoryImpl extends CurrencyRepository {
  final CurrencyRemoteDataSource remoteDataSource;
  final CurrencyLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final FlavorConfig flavorConfig;

  CurrencyRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.flavorConfig,
  });

  @override
  Future<Either<Failure, CurrencyConvertResponseEntity>> convertCurrency(
      ConvertCurrencyParams params) async {
    if (await networkInfo.isConnected) {
      return await _fetchFromRemoteOrLocal(params);
    } else {
      return await _fetchFromLocal(params, isNetworkConnected: false);
    }
  }

  Future<Either<Failure, CurrencyConvertResponseEntity>>
      _fetchFromRemoteOrLocal(ConvertCurrencyParams params) async {
    try {
      final result = await remoteDataSource.convertCurrency(params);
      return Right(result);
    } catch (e) {
      return await _fetchFromLocal(params);
    }
  }

  Future<Either<Failure, CurrencyConvertResponseEntity>> _fetchFromLocal(
      ConvertCurrencyParams params,
      {bool isNetworkConnected = true}) async {
    try {
      final result = await localDataSource.getConvertCurrency(params);
      if (result == null) {
        throw CacheException();
      }
      return Right(result);
    } on Exception catch (_) {
      return Left(fromExceptionToFailure(
          isNetworkConnected ? ServerException() : NetworkException()));
    }
  }

  @override
  Future<Either<Failure, CurrencyResponseEntity>> getCurrencyList() async {
    try {
      final localResult = await _getLocalCurrencyList();
      return Right(localResult);
    } on CacheException catch (_) {
      if (await networkInfo.isConnected) {
        return await _fetchAndCacheRemoteCurrencyList();
      } else {
        return const Left(NetworkFailure());
      }
    }
  }

  Future<CurrencyResponseEntity> _getLocalCurrencyList() async {
    final localResult = await localDataSource.getCurrencyList();
    if (localResult != null) {
      return localResult;
    } else {
      throw CacheException();
    }
  }

  Future<Either<Failure, CurrencyResponseEntity>>
      _fetchAndCacheRemoteCurrencyList() async {
    try {
      final remoteResult =
          await remoteDataSource.getCurrencyList(flavorConfig.currencyApiKey);
      await _addCurrencyDetails(remoteResult);
      await localDataSource.cacheCurrencyList(remoteResult);
      return Right(remoteResult);
    } on Exception catch (_) {
      return const Left(ServerFailure());
    }
  }

  Future<void> _addCurrencyDetails(CurrencyResponseEntity remoteResult) async {
    final jsonString =
        await rootBundle.loadString('assets/data/currencies.json');
    final List<dynamic> jsonFile = json.decode(jsonString);

    final Map<String, Map<String, String>> currencyDetails = {
      for (var currency in jsonFile)
        currency['code'] ?? '': {
          'countryCode': currency['countryCode'] ?? '',
          'flagUrl': currency['flag'] ?? ''
        }
    };

    remoteResult.symbols?.forEach((element) {
      var details = currencyDetails[element.currencyCode];
      if (details != null &&
          !Constants.unwantedCountries.contains(details['countryCode'])) {
        element.imageUrl =
            "https://flagcdn.com/48x36/${details['countryCode']?.toLowerCase()}.png";
        element.base64Image = details['flagUrl'];
      }
    });
  }

  @override
  Future<Either<Failure, HistoricalCurrencyResponseEntity>>
      getHistoricalCurrencyData(HistoricalCurrencyParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getHistoricalData(params);
        return Right(result);
      } on Exception catch (_) {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final result = await localDataSource.getHistoricalData(params);
        if (result == null) {
          throw CacheException();
        }
        return Right(result);
      } on Exception catch (_) {
        return const Left(CacheFailure());
      }
    }
  }
}
